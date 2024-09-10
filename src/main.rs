pub mod asset;
pub mod github;
pub mod metadata;
pub mod nix;

use std::{
    fs::File,
    io::{BufWriter, Write},
    path::{Path, PathBuf},
};

use asset::Asset;
use clap::Parser;
use color_eyre::{eyre::eyre, Result};
use futures_util::StreamExt;
use tracing::info;
use tracing_subscriber::{prelude::*, EnvFilter};

use crate::metadata::{EspRelease, LlvmRelease, RustRelease, RustSrcRelease};

#[tokio::main]
async fn main() -> Result<()> {
    color_eyre::install().unwrap();
    let env_filter =
        EnvFilter::try_from_default_env().or_else(|_| EnvFilter::try_new("manifester=trace"))?;
    let stdout_layer = tracing_subscriber::fmt::layer().with_filter(env_filter);
    tracing_subscriber::registry().with(stdout_layer).init();

    let args = Args::parse();

    let rust_releases = metadata::fetch_bin::<RustRelease>("esp-rs/rust-build")
        .await?
        .collect::<Vec<_>>();
    let rust_src_releases = metadata::fetch_src::<RustSrcRelease>("esp-rs/rust-build")
        .await?
        .collect::<Vec<_>>();
    let llvm_releases = metadata::fetch_bin::<LlvmRelease>("espressif/llvm-project")
        .await?
        .collect::<Vec<_>>();
    let esp_releases = metadata::fetch_bin::<EspRelease>("espressif/crosstool-NG")
        .await?
        .collect::<Vec<_>>();

    if rust_releases.is_empty() {
        return Err(eyre!("no rust releases found, something is wrong"));
    } else if rust_src_releases.is_empty() {
        return Err(eyre!("no rust src releases found, something is wrong"));
    } else if llvm_releases.is_empty() {
        return Err(eyre!("no llvm releases found, something is wrong"));
    } else if esp_releases.is_empty() {
        return Err(eyre!("no esp releases found, something is wrong"));
    }

    let releases = rust_releases
        .into_iter()
        .chain(rust_src_releases)
        .chain(llvm_releases)
        .chain(esp_releases);

    let mut assets = asset::fetch(releases, 8)
        .collect::<Vec<_>>() // TODO: can I avoid this collection?
        .await
        .into_iter()
        .collect::<Result<Vec<_>>>()?;
    assets.sort_unstable_by_key(|asset| (asset.metadata.name.clone(), asset.metadata.target));

    write_manifest(&args.output_path, &assets)?;
    info!(
        "wrote manifest to `{}`",
        &args.output_path.to_string_lossy()
    );

    Ok(())
}

fn write_manifest<P: AsRef<Path>>(path: P, assets: &[Asset]) -> Result<()> {
    let mut manifest = BufWriter::new(File::create(path)?);

    writeln!(manifest, "rec {{")?;
    for asset in assets {
        write!(manifest, "{}", textwrap::indent(&asset.to_nix_src()?, "  "))?;
    }
    writeln!(manifest, "}}")?;

    Ok(())
}

#[derive(Parser, Debug)]
#[command(author, version, about, long_about = None)]
struct Args {
    /// Output Nix manifest path.
    #[arg(short, long, default_value = "./manifests.nix")]
    output_path: PathBuf,
}
