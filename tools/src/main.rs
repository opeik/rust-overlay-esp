mod github;

use color_eyre::Result;
use github::{Release, ReleaseAsset};
use indoc::formatdoc;

const TARGETS: &[Target] = &[
    Target {
        platform: "linux",
        arch: "aarch64",
    },
    Target {
        platform: "linux",
        arch: "x86_64",
    },
    Target {
        platform: "darwin",
        arch: "aarch64",
    },
    Target {
        platform: "darwin",
        arch: "x86_64",
    },
];

#[tokio::main]
async fn main() -> Result<()> {
    color_eyre::install().unwrap();

    let client = github::new_client()?;

    let repos = [
        "esp-rs/rust-build",
        "espressif/llvm-project",
        "espressif/llvm-project",
        "espressif/crosstool-NG",
    ];

    for repo in &repos {
        let release = github::fetch_latest_release(&client, repo).await?;
        let mut assets = filter_release_assets(&release, TARGETS);
        assets.sort_by(|a, b| {
            let a = a.target.name();
            let b = b.target.name();
            a.partial_cmp(&b).unwrap()
        });

        for asset in &assets {
            println!("{}", asset_to_nix(asset));
        }
    }

    Ok(())
}

/// It just works™.
fn filter_release_assets<'a>(release: &'a Release, targets: &'a [Target]) -> Vec<TargetAsset<'a>> {
    targets
        .iter()
        .flat_map(|target| {
            release
                .assets
                .iter()
                .filter(|asset| asset.name.contains(target.platform))
                .filter(|asset| asset.name.contains(target.arch))
                .map(|asset| TargetAsset {
                    target: target.clone(),
                    asset,
                })
                .collect::<Vec<_>>()
        })
        .collect::<Vec<_>>()
}

fn asset_to_nix(asset: &TargetAsset) -> String {
    let name = asset.target.name();
    let url = asset.asset.browser_download_url.as_str();
    let sha256 = "";

    formatdoc! {
        r#"
        {name} = {{
            url = "{url}",
            sha256 = "{sha256}",
        }}"#,
    }
}

#[derive(Debug, Clone)]
pub struct TargetAsset<'a> {
    pub target: Target<'a>,
    pub asset: &'a ReleaseAsset,
}

#[derive(Debug, Clone)]
pub struct Target<'a> {
    platform: &'a str,
    arch: &'a str,
}

impl<'a> Target<'a> {
    pub fn name(&self) -> String {
        format!("{}-{}", self.arch, self.platform)
    }
}
