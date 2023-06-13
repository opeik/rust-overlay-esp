use std::path::Path;

use color_eyre::Result;
use futures_util::{stream, StreamExt};
use tools::{asset, github, nix::targets::*};
use tracing::info;

#[tokio::main]
async fn main() -> Result<()> {
    color_eyre::install().unwrap();
    tracing_subscriber::fmt::init();

    let client = github::new_client()?;
    let targets = [AARCH64_DARWIN, AARCH64_LINUX, X86_64_DARWIN, X86_64_LINUX];
    let download_dir = Path::new("./tmp");
    std::fs::create_dir_all(download_dir)?;

    let rust_release = github::fetch_latest_release(&client, "esp-rs/rust-build").await?;
    let asset_names = rust_release
        .assets
        .iter()
        .map(|asset| asset.name.as_str())
        .collect::<Vec<_>>();
    info!("fetched latest release assets: {asset_names:?}");

    let rust_assets = targets
        .iter()
        .flat_map(|target| asset::filter_rust_assets(&rust_release, target))
        .inspect(|target_asset| info!("found rust asset: `{}`", target_asset.asset.name))
        .collect::<Vec<_>>();
    let rust_files = stream::iter(rust_assets)
        .then(|target_asset| async { (target_asset.download(&download_dir).await, target_asset) })
        .inspect(|(digest, target_asset)| {
            info!("downloaded `{}`: {digest:?}", target_asset.asset.name)
        })
        .collect::<Vec<_>>()
        .await;

    for (digest, target_asset) in rust_files {
        let nix_code = target_asset.to_nix(&digest?)?;
        println!("{nix_code}");
    }

    // let llvm_release = github::fetch_latest_release(&client,
    // "espressif/llvm-project").await?; let llvm_assets = targets
    //     .iter()
    //     .flat_map(|target| asset::filter_llvm_assets(&llvm_release, target))
    //     .collect::<Vec<_>>();

    // let esp_release = github::fetch_latest_release(&client,
    // "espressif/crosstool-NG").await?; let esp_assets = targets
    //     .iter()
    //     .flat_map(|target| asset::filter_esp_assets(&esp_release, target))
    //     .collect::<Vec<_>>();

    Ok(())
}
