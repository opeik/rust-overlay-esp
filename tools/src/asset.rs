use crate::{
    github::{Release, ReleaseAsset},
    nix::Target,
};
use color_eyre::{
    eyre::{eyre, ContextCompat},
    Result,
};
use indoc::formatdoc;
use lazy_regex::{regex, Lazy, Regex};
use std::str::FromStr;
use target_lexicon::{Architecture, OperatingSystem};

macro_rules! capture_str {
    ($captures:ident, $name:expr) => {
        $captures
            .name($name)
            .wrap_err("failed to match {$name}")?
            .as_str()
    };
}

/// Filters all Rust assets in a GitHub [`Release`] for the Nix [`Target`].
pub fn filter_rust_assets<'a>(release: &'a Release, target: &Target) -> Vec<TargetAsset<'a>> {
    let regex: &Lazy<Regex> = regex!(
        r"(?P<name>rust)-(?P<version>.+?)-(?P<arch>.+?)-(?P<vendor>.+?)-(?P<os>.+?)(-(?P<env>.+?))?\.(?P<ext>.+)"
    );

    release
        .assets
        .iter()
        .filter(|asset| regex.is_match(&asset.name))
        .map(|asset| {
            let captures = regex.captures(&asset.name).unwrap();
            let arch = Architecture::from_str(capture_str!(captures, "arch"))
                .map_err(|_| eyre!("invalid arch"))?;
            let os = OperatingSystem::from_str(capture_str!(captures, "os"))
                .map_err(|_| eyre!("invalid os"))?;
            Ok(TargetAsset {
                target: Target { arch, os },
                asset,
                name: capture_str!(captures, "name"),
                version: capture_str!(captures, "version"),
            })
        })
        .filter_map(|x: Result<TargetAsset>| x.ok())
        .filter(|x| x.target == *target)
        .collect::<Vec<_>>()
}

/// Filters all LLVM library assets in a GitHub [`Release`] for the Nix
/// [`Target`].
pub fn filter_llvm_assets<'a>(release: &'a Release, target: &Target) -> Vec<TargetAsset<'a>> {
    let regex: &Lazy<Regex> =
        regex!(r"(?P<name>libs_llvm)-(?P<version>.+\d)-(?P<os>.+?)(-(?P<arch>.+?))?\.(?P<ext>.+)");

    release
        .assets
        .iter()
        .filter(|asset| regex.is_match(&asset.name))
        .map(|asset| {
            let captures = regex.captures(&asset.name).unwrap();
            let arch_str = match captures
                .name("arch")
                .map(|x| x.as_str())
                .unwrap_or("x86_64")
            {
                "amd64" => "x86_64",
                arch_str => arch_str,
            };
            let arch = Architecture::from_str(arch_str)
                .map_err(|_| eyre!("failed to parse architecture"))?;
            let os_str = match captures
                .name("os")
                .wrap_err("failed to match operating system")?
                .as_str()
            {
                "macos" => "darwin",
                os_str => os_str,
            };
            let os = OperatingSystem::from_str(os_str)
                .map_err(|_| eyre!("failed to parse operating system"))?;

            Ok(TargetAsset {
                target: Target { arch, os },
                asset,
                name: capture_str!(captures, "name"),
                version: capture_str!(captures, "version"),
            })
        })
        .filter_map(|x: Result<TargetAsset>| x.ok())
        .filter(|x| x.target == *target)
        .collect::<Vec<_>>()
}

/// Filters all ESP assets in a GitHub [`Release`] for the Nix [`Target`].
pub fn filter_esp_assets<'a>(release: &'a Release, target: &Target) -> Vec<TargetAsset<'a>> {
    let regex: &Lazy<Regex> = regex!(
        r"(?P<name>.+)-(?P<version>.+?)-(?P<arch>.+?)-(?P<os>.+?)-(?P<env>.+?)\.(?P<ext>.+)"
    );

    release
        .assets
        .iter()
        .filter(|asset| regex.is_match(&asset.name))
        .map(|asset| {
            let captures = regex.captures(&asset.name).unwrap();
            let arch = Architecture::from_str(capture_str!(captures, "arch"))
                .map_err(|_| eyre!("invalid arch"))?;
            let os_str = match captures
                .name("os")
                .wrap_err("failed to match operating system")?
                .as_str()
            {
                "apple" => "darwin",
                os_str => os_str,
            };
            let os = OperatingSystem::from_str(os_str)
                .map_err(|_| eyre!("failed to parse operating system"))?;
            Ok(TargetAsset {
                target: Target { arch, os },
                asset,
                name: capture_str!(captures, "name"),
                version: capture_str!(captures, "version"),
            })
        })
        .filter_map(|x: Result<TargetAsset>| x.ok())
        .filter(|x| x.target == *target)
        .collect::<Vec<_>>()
}

pub fn asset_to_nix(asset: &TargetAsset) -> String {
    let name = "foo";
    let url = asset.asset.browser_download_url.as_str();
    // TODO: calculate the sha256 hash you dumbass
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
    pub target: Target,
    pub asset: &'a ReleaseAsset,
    pub name: &'a str,
    pub version: &'a str,
}
