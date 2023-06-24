#![feature(async_fn_in_trait)]
#![feature(return_position_impl_trait_in_trait)]

pub mod asset;
pub mod github;
pub mod metadata;
pub mod nix;

use std::{
    fs::File,
    io::{BufWriter, Write},
    path::PathBuf,
};

use clap::Parser;
use color_eyre::Result;
use futures_util::StreamExt;
use tracing::{info, Level};
use tracing_subscriber::{prelude::*, EnvFilter};

use crate::metadata::{EspRelease, LlvmRelease, RustRelease, RustSrcRelease};

#[tokio::main]
async fn main() -> Result<()> {
    color_eyre::install().unwrap();
    let env_filter = EnvFilter::builder()
        .with_default_directive(Level::INFO.into())
        .from_env_lossy();
    let stdout_layer = tracing_subscriber::fmt::layer().with_filter(env_filter);
    tracing_subscriber::registry().with(stdout_layer).init();

    let args = Args::parse();

    let rust_releases = metadata::fetch_bin::<RustRelease>("esp-rs/rust-build").await?;
    let rust_src_releases = metadata::fetch_src::<RustSrcRelease>("esp-rs/rust-build").await?;
    let llvm_releases = metadata::fetch_bin::<LlvmRelease>("espressif/llvm-project").await?;
    let esp_releases = metadata::fetch_bin::<EspRelease>("espressif/crosstool-NG").await?;
    let releases = rust_releases
        .chain(rust_src_releases)
        .chain(llvm_releases)
        .chain(esp_releases);
    let assets = asset::fetch(releases, 8).collect::<Vec<_>>().await;

    let output_path = args.output_path;
    let mut manifest = BufWriter::new(File::create(output_path.as_path())?);

    writeln!(manifest, "rec {{")?;
    for asset in assets {
        let nix_src = asset?.to_nix_src()?;
        write!(manifest, "{}", textwrap::indent(nix_src.as_str(), "  "))?;
    }
    writeln!(manifest, "}}")?;

    info!("wrote manifest to `{}`", output_path.to_string_lossy());
    Ok(())
}

#[derive(Parser, Debug)]
#[command(author, version, about, long_about = None)]
struct Args {
    /// Output Nix manifest path.
    #[arg(short, long, default_value = "./manifests.nix")]
    output_path: PathBuf,
}
