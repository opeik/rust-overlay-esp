use color_eyre::Result;
use tools::{asset, github, nix::targets::*};

#[tokio::main]
async fn main() -> Result<()> {
    color_eyre::install().unwrap();

    let client = github::new_client()?;
    let targets = [AARCH64_DARWIN, AARCH64_LINUX, X86_64_DARWIN, X86_64_LINUX];

    let rust_release = github::fetch_latest_release(&client, "esp-rs/rust-build").await?;
    let rust_assets = targets
        .iter()
        .flat_map(|target| asset::filter_rust_assets(&rust_release, target))
        .collect::<Vec<_>>();

    let llvm_release = github::fetch_latest_release(&client, "espressif/llvm-project").await?;
    let llvm_assets = targets
        .iter()
        .flat_map(|target| asset::filter_llvm_assets(&llvm_release, target))
        .collect::<Vec<_>>();

    let esp_release = github::fetch_latest_release(&client, "espressif/crosstool-NG").await?;
    let esp_assets = targets
        .iter()
        .flat_map(|target| asset::filter_esp_assets(&esp_release, target))
        .collect::<Vec<_>>();

    dbg!(rust_assets, llvm_assets, esp_assets);
    Ok(())
}
