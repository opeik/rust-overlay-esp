use std::str::FromStr;

use color_eyre::{
    eyre::{eyre, ContextCompat},
    Result,
};
use lazy_regex::{lazy_regex, Lazy, Regex};
use nutype::nutype;
use target_lexicon::{Architecture, OperatingSystem};
use url::Url;

use crate::{github::Github, nix::Target};

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

/// Matches components of a Rust release filename.
static RUST_RELEASE_REGEX: Lazy<Regex> = lazy_regex!(
    r"(?P<name>rust)-(?P<version>.+?)-(?P<arch>.+?)-(?P<vendor>.+?)-(?P<os>.+?)(-(?P<env>.+?))?\.(?P<ext>.+)"
);

/// Matches components of a Rust source release filename.
static RUST_SRC_RELEASE_REGEX: Lazy<Regex> =
    lazy_regex!(r"(?P<name>rust-src)-(?P<version>.*\d)\.(?P<ext>.+)");

/// Matches components of an ESP release filename.
static ESP_RELEASE_REGEX: Lazy<Regex> = lazy_regex!(
    r"(?P<name>.+)-(?P<version>.+?)-(?P<arch>.+?)-(?P<os>.+?)-(?P<env>.+?)\.(?P<ext>.+)"
);

/// Matches components of an LLVM release filename.
static LLVM_RELEASE_REGEX: Lazy<Regex> =
    lazy_regex!(r"(?P<name>libs_llvm)-(?P<version>.+\d)-(?P<os>.+?)(-(?P<arch>.+?))?\.(?P<ext>.+)");

#[nutype(validate(min_len = 64, max_len = 64))]
#[derive(Debug, Clone, AsRef)]
pub struct Sha256Digest(String);

#[nutype(validate(min_len = 1))]
#[derive(Debug, Clone, AsRef)]
pub struct Name(String);

#[nutype(validate(min_len = 1))]
#[derive(Debug, Clone, AsRef)]
pub struct Version(String);

#[derive(Debug, Clone)]
pub struct RawMetadata {
    pub name: Name,
    pub url: Url,
}

#[derive(Debug, Clone)]
pub struct Metadata {
    pub name: Name,
    pub version: Version,
    pub target: Option<Target>,
    pub url: Url,
}

pub trait Fetch {
    async fn fetch<P: Parse>(url: &Url) -> Result<impl Iterator<Item = Result<Metadata>>>;
}

pub trait Parse {
    fn parse(value: RawMetadata) -> Result<Metadata>;
}

pub async fn fetch<P: Parse>(
    repo: &str,
    targets: impl IntoIterator<Item = Option<Target>>,
) -> Result<impl Iterator<Item = Metadata>> {
    let base = Url::parse("https://github.com")?;
    let targets = targets.into_iter().collect::<Vec<_>>();
    let metadata = Github::fetch::<P>(&base.join(repo)?)
        .await?
        .flatten()
        .filter(move |x| targets.contains(&x.target));
    Ok(metadata)
}

pub async fn fetch_bin<P: Parse>(repo: &str) -> Result<impl Iterator<Item = Metadata>> {
    use crate::nix::targets::*;
    let targets = [AARCH64_DARWIN, AARCH64_LINUX, X86_64_DARWIN, X86_64_LINUX].map(Some);
    fetch::<P>(repo, targets).await
}

pub async fn fetch_src<P: Parse>(repo: &str) -> Result<impl Iterator<Item = Metadata>> {
    fetch::<P>(repo, [None]).await
}

pub struct RustRelease;
impl Parse for RustRelease {
    fn parse(value: RawMetadata) -> Result<Metadata> {
        let regex = &RUST_RELEASE_REGEX;
        let name = value.name.into_inner();
        let captures = regex
            .captures(&name)
            .context("failed to parse rust release metadata")?;
        Ok(Metadata {
            target: Some(Target {
                arch: Architecture::from_str(capture_str!(captures, "arch"))
                    .map_err(|_| eyre!("invalid arch"))?,
                os: OperatingSystem::from_str(capture_str!(captures, "os"))
                    .map_err(|_| eyre!("invalid os"))?,
            }),
            name: Name::new(capture_string!(captures, "name"))?,
            version: Version::new(capture_string!(captures, "version"))?,
            url: value.url.as_str().try_into()?,
        })
    }
}

pub struct RustSrcRelease;
impl Parse for RustSrcRelease {
    fn parse(value: RawMetadata) -> Result<Metadata> {
        let regex = &RUST_SRC_RELEASE_REGEX;
        let name = value.name.into_inner();
        let captures = regex
            .captures(&name)
            .context("failed to parse rust-src release metadata")?;
        Ok(Metadata {
            target: None,
            name: Name::new(capture_string!(captures, "name"))?,
            version: Version::new(capture_string!(captures, "version"))?,
            url: value.url.as_str().try_into()?,
        })
    }
}

pub struct LlvmRelease;
impl Parse for LlvmRelease {
    fn parse(value: RawMetadata) -> Result<Metadata> {
        let regex = &LLVM_RELEASE_REGEX;
        let name = value.name.into_inner();
        let captures = regex
            .captures(&name)
            .context("failed to parse rust release metadata")?;

        let arch_str = match captures
            .name("arch")
            .map(|x| x.as_str())
            .unwrap_or("x86_64")
        {
            "amd64" => "x86_64",
            arch_str => arch_str,
        };

        let os_str = match captures.name("os").wrap_err("invalid os")?.as_str() {
            "macos" => "darwin",
            os_str => os_str,
        };

        Ok(Metadata {
            target: Some(Target {
                arch: Architecture::from_str(arch_str).map_err(|_| eyre!("invalid arch"))?,
                os: OperatingSystem::from_str(os_str).map_err(|_| eyre!("invalid os"))?,
            }),
            name: Name::new(capture_string!(captures, "name"))?,
            version: Version::new(capture_string!(captures, "version"))?,
            url: value.url.as_str().try_into()?,
        })
    }
}

pub struct EspRelease;
impl Parse for EspRelease {
    fn parse(value: RawMetadata) -> Result<Metadata> {
        let regex = &ESP_RELEASE_REGEX;
        let name = value.name.into_inner();
        let captures = regex
            .captures(&name)
            .context("failed to parse rust release metadata")?;

        let os_str = match captures.name("os").wrap_err("invalid os")?.as_str() {
            "apple" => "darwin",
            os_str => os_str,
        };

        Ok(Metadata {
            target: Some(Target {
                arch: Architecture::from_str(capture_str!(captures, "arch"))
                    .map_err(|_| eyre!("invalid arch"))?,
                os: OperatingSystem::from_str(os_str).map_err(|_| eyre!("invalid os"))?,
            }),
            name: Name::new(capture_string!(captures, "name"))?,
            version: Version::new(capture_string!(captures, "version"))?,
            url: value.url.as_str().try_into()?,
        })
    }
}

#[cfg(test)]
mod test {
    use std::collections::BTreeMap;

    use maplit::btreemap;

    use super::*;

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
        let regex = &RUST_RELEASE_REGEX;
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
        let regex = &RUST_SRC_RELEASE_REGEX;
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
        let regex = &LLVM_RELEASE_REGEX;

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
        let regex = &ESP_RELEASE_REGEX;

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
