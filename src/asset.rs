use crate::{
    github::{Asset, Release},
    nix::Target,
};
use color_eyre::{
    eyre::{eyre, ContextCompat},
    Result,
};
use data_encoding::HEXLOWER;
use futures_util::StreamExt;
use indoc::formatdoc;
use lazy_regex::{lazy_regex, Lazy, Regex};
use ring::digest::{Context, Digest, SHA256};
use std::str::FromStr;
use target_lexicon::{Architecture, OperatingSystem};

#[derive(Debug, Clone)]
pub struct NixAsset {
    pub target: Option<Target>,
    pub asset: Asset,
    pub name: String,
    pub version: String,
}

impl NixAsset {
    pub fn to_nix_src(&self, digest: &Digest) -> Result<String> {
        let target = self.target.map(|x| x.to_string());
        let name = self.name.as_str();
        let version = self.version.replace('.', "_");
        let url = self.asset.browser_download_url.as_str();
        let sha256 = HEXLOWER.encode(digest.as_ref());

        let src = match target {
            Some(target) => formatdoc! {r#"
                bin.{target}.{name}-{version} = {{
                  url = "{url}";
                  sha256 = "{sha256}";
                }};
                latest.bin.{target}.{name} = bin.{target}.{name}-{version};
            "#},
            // No target implies it's a source asset.
            None => formatdoc! {r#"
                src.{name}-{version} = {{
                  url = "{url}";
                  sha256 = "{sha256}";
                }};
                latest.src.{name} = src.{name}-{version};
            "#},
        };

        Ok(src)
    }

    pub async fn fetch_digest(&self) -> Result<Digest> {
        fetch_digest(&self.asset.browser_download_url).await
    }
}

async fn fetch_digest(url: &str) -> Result<Digest> {
    let mut stream = reqwest::get(url).await?.bytes_stream();
    let mut context = Context::new(&SHA256);

    while let Some(chunk_result) = stream.next().await {
        let chunk = chunk_result?;
        context.update(&chunk)
    }

    Ok(context.finish())
}

macro_rules! capture_str {
    ($captures:ident, $name:expr) => {
        $captures
            .name($name)
            .wrap_err("failed to match {$name}")?
            .as_str()
    };
}

macro_rules! capture_string {
    ($captures:ident, $name:expr) => {
        capture_str!($captures, $name).to_string()
    };
}

static RUST_ASSET_REGEX: Lazy<Regex> = lazy_regex!(
    r"(?P<name>rust)-(?P<version>.+?)-(?P<arch>.+?)-(?P<vendor>.+?)-(?P<os>.+?)(-(?P<env>.+?))?\.(?P<ext>.+)"
);

static RUST_SRC_ASSET_REGEX: Lazy<Regex> =
    lazy_regex!(r"(?P<name>rust-src)-(?P<version>.*\d)\.(?P<ext>.+)");

static ESP_ASSET_REGEX: Lazy<Regex> = lazy_regex!(
    r"(?P<name>.+)-(?P<version>.+?)-(?P<arch>.+?)-(?P<os>.+?)-(?P<env>.+?)\.(?P<ext>.+)"
);

static LLVM_ASSET_REGEX: Lazy<Regex> =
    lazy_regex!(r"(?P<name>libs_llvm)-(?P<version>.+\d)-(?P<os>.+?)(-(?P<arch>.+?))?\.(?P<ext>.+)");

/// Filters all Rust assets in a GitHub [`Release`] for the Nix [`Target`].
pub fn filter_rust_assets(release: &Release, target: &Target) -> Vec<NixAsset> {
    let regex = &RUST_ASSET_REGEX;
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
            Ok(NixAsset {
                target: Some(Target { arch, os }),
                asset: asset.clone(),
                name: capture_string!(captures, "name"),
                version: capture_string!(captures, "version"),
            })
        })
        .filter_map(|x: Result<NixAsset>| x.ok())
        .filter(|x| x.target == Some(*target))
        .collect::<Vec<_>>()
}

/// Filters all Rust source assets in a GitHub [`Release`] for the Nix
/// [`Target`].
pub fn filter_rust_src_assets(release: &Release) -> Vec<NixAsset> {
    let regex = &RUST_SRC_ASSET_REGEX;
    release
        .assets
        .iter()
        .filter(|asset| regex.is_match(&asset.name))
        .map(|asset| {
            let captures = regex.captures(&asset.name).unwrap();
            Ok(NixAsset {
                target: None,
                asset: asset.clone(),
                name: capture_string!(captures, "name"),
                version: capture_string!(captures, "version"),
            })
        })
        .filter_map(|x: Result<NixAsset>| x.ok())
        .collect::<Vec<_>>()
}

/// Filters all LLVM library assets in a GitHub [`Release`] for the Nix
/// [`Target`].
pub fn filter_llvm_assets(release: &Release, target: &Target) -> Vec<NixAsset> {
    let regex = &LLVM_ASSET_REGEX;
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
            let arch = Architecture::from_str(arch_str).map_err(|_| eyre!("invalid arch"))?;
            let os_str = match captures.name("os").wrap_err("invalid os")?.as_str() {
                "macos" => "darwin",
                os_str => os_str,
            };
            let os = OperatingSystem::from_str(os_str).map_err(|_| eyre!("invalid os"))?;

            Ok(NixAsset {
                target: Some(Target { arch, os }),
                asset: asset.clone(),
                name: capture_string!(captures, "name"),
                version: capture_string!(captures, "version"),
            })
        })
        .filter_map(|x: Result<NixAsset>| x.ok())
        .filter(|x| x.target == Some(*target))
        .collect::<Vec<_>>()
}

/// Filters all ESP assets in a GitHub [`Release`] for the Nix [`Target`].
pub fn filter_esp_assets(release: &Release, target: &Target) -> Vec<NixAsset> {
    let regex = &ESP_ASSET_REGEX;
    release
        .assets
        .iter()
        .filter(|asset| regex.is_match(&asset.name))
        .map(|asset| {
            let captures = regex.captures(&asset.name).unwrap();
            let arch = Architecture::from_str(capture_str!(captures, "arch"))
                .map_err(|_| eyre!("invalid arch"))?;
            let os_str = match captures.name("os").wrap_err("invalid os")?.as_str() {
                "apple" => "darwin",
                os_str => os_str,
            };
            let os = OperatingSystem::from_str(os_str).map_err(|_| eyre!("invalid os"))?;
            Ok(NixAsset {
                target: Some(Target { arch, os }),
                asset: asset.clone(),
                name: capture_string!(captures, "name"),
                version: capture_string!(captures, "version"),
            })
        })
        .filter_map(|x: Result<NixAsset>| x.ok())
        .filter(|x| x.target == Some(*target))
        .collect::<Vec<_>>()
}

#[cfg(test)]
mod test {
    use super::*;
    use maplit::btreemap;
    use std::collections::BTreeMap;

    fn regex_captures<'a>(regex: &'a Regex, s: &'a str) -> Result<BTreeMap<&'a str, &'a str>> {
        let captures = regex.captures(s).wrap_err(eyre!("no captures found"))?;
        Ok(regex
            .capture_names()
            .flatten()
            .filter_map(|n| Some((n, captures.name(n)?.as_str())))
            .collect::<BTreeMap<&'a str, &'a str>>())
    }

    #[test]
    fn rust_regex() -> Result<()> {
        let regex = &RUST_ASSET_REGEX;
        assert_eq!(
            regex_captures(regex, "rust-1.70.0.1-aarch64-apple-darwin.tar.xz")?,
            btreemap! {
                "name" => "rust",
                "version" => "1.70.0.1",
                "arch" => "aarch64",
                "vendor" => "apple",
                "os" => "darwin",
                "ext" => "tar.xz",
            }
        );

        assert_eq!(
            regex_captures(regex, "rust-1.70.0.1-x86_64-apple-darwin.tar.xz")?,
            btreemap! {
                "name" => "rust",
                "version" => "1.70.0.1",
                "arch" => "x86_64",
                "vendor" => "apple",
                "os" => "darwin",
                "ext" => "tar.xz",
            }
        );

        assert_eq!(
            regex_captures(regex, "rust-1.70.0.1-aarch64-unknown-linux-gnu.tar.xz")?,
            btreemap! {
                "name" => "rust",
                "version" => "1.70.0.1",
                "arch" => "aarch64",
                "vendor" => "unknown",
                "os" => "linux",
                "env" => "gnu",
                "ext" => "tar.xz",
            }
        );

        assert_eq!(
            regex_captures(regex, "rust-1.70.0.1-x86_64-unknown-linux-gnu.tar.xz")?,
            btreemap! {
                "name" => "rust",
                "version" => "1.70.0.1",
                "arch" => "x86_64",
                "vendor" => "unknown",
                "os" => "linux",
                "env" => "gnu",
                "ext" => "tar.xz",
            }
        );

        Ok(())
    }

    #[test]
    fn rust_src_regex() -> Result<()> {
        let regex = &RUST_SRC_ASSET_REGEX;
        assert_eq!(
            regex_captures(regex, "rust-src-1.70.0.1.tar.xz")?,
            btreemap! {
                "name" => "rust-src",
                "version" => "1.70.0.1",
                "ext" => "tar.xz",
            }
        );
        Ok(())
    }

    #[test]
    fn llvm_regex() -> Result<()> {
        let regex = &LLVM_ASSET_REGEX;

        assert_eq!(
            regex_captures(regex, "libs_llvm-esp-16.0.0-20230516-linux-arm64.tar.xz")?,
            btreemap! {
                "name" => "libs_llvm",
                "version" => "esp-16.0.0-20230516",
                "os" => "linux",
                "arch" => "arm64",
                "ext" => "tar.xz",
            }
        );

        assert_eq!(
            regex_captures(regex, "libs_llvm-esp-16.0.0-20230516-linux-amd64.tar.xz")?,
            btreemap! {
                "name" => "libs_llvm",
                "version" => "esp-16.0.0-20230516",
                "os" => "linux",
                "arch" => "amd64",
                "ext" => "tar.xz",
            }
        );

        assert_eq!(
            regex_captures(regex, "libs_llvm-esp-16.0.0-20230516-macos-arm64.tar.xz")?,
            btreemap! {
                "name" => "libs_llvm",
                "version" => "esp-16.0.0-20230516",
                "os" => "macos",
                "arch" => "arm64",
                "ext" => "tar.xz",
            }
        );

        assert_eq!(
            regex_captures(regex, "libs_llvm-esp-16.0.0-20230516-macos.tar.xz")?,
            btreemap! {
                "name" => "libs_llvm",
                "version" => "esp-16.0.0-20230516",
                "os" => "macos",
                "ext" => "tar.xz",
            }
        );

        Ok(())
    }

    #[test]
    fn esp_regex() -> Result<()> {
        let regex = &ESP_ASSET_REGEX;

        assert_eq!(
            regex_captures(
                regex,
                "riscv32-esp-elf-12.2.0_20230208-aarch64-apple-darwin.tar.xz"
            )?,
            btreemap! {
                "name" => "riscv32-esp-elf",
                "version" => "12.2.0_20230208",
                "arch" => "aarch64",
                "os" => "apple",
                "env" => "darwin",
                "ext" => "tar.xz",
            }
        );

        assert_eq!(
            regex_captures(
                regex,
                "riscv32-esp-elf-12.2.0_20230208-x86_64-apple-darwin.tar.xz"
            )?,
            btreemap! {
                "name" => "riscv32-esp-elf",
                "version" => "12.2.0_20230208",
                "arch" => "x86_64",
                "os" => "apple",
                "env" => "darwin",
                "ext" => "tar.xz",
            }
        );

        assert_eq!(
            regex_captures(
                regex,
                "riscv32-esp-elf-12.2.0_20230208-aarch64-linux-gnu.tar.xz"
            )?,
            btreemap! {
                "name" => "riscv32-esp-elf",
                "version" => "12.2.0_20230208",
                "arch" => "aarch64",
                "os" => "linux",
                "env" => "gnu",
                "ext" => "tar.xz",
            }
        );

        assert_eq!(
            regex_captures(
                regex,
                "riscv32-esp-elf-12.2.0_20230208-x86_64-linux-gnu.tar.xz"
            )?,
            btreemap! {
                "name" => "riscv32-esp-elf",
                "version" => "12.2.0_20230208",
                "arch" => "x86_64",
                "os" => "linux",
                "env" => "gnu",
                "ext" => "tar.xz",
            }
        );

        Ok(())
    }
}
