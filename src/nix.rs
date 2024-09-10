use color_eyre::{eyre::ContextCompat, Result};
use indoc::formatdoc;
use target_lexicon::{Aarch64Architecture, Architecture, OperatingSystem};

use crate::asset::Asset;

#[derive(Debug, Copy, Clone, PartialEq, Eq)]
pub struct Target {
    pub arch: Architecture,
    pub os: OperatingSystem,
}

impl Ord for Target {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        self.to_string().cmp(&other.to_string())
    }
}

impl PartialOrd for Target {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

impl std::fmt::Display for Target {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        use targets::*;
        let s = match *self {
            AARCH64_DARWIN => "aarch64-darwin",
            X86_64_DARWIN => "x86_64-darwin",
            AARCH64_LINUX => "aarch64-linux",
            X86_64_LINUX => "x86_64-linux",
            _ => panic!("invalid target"),
        }
        .to_string();
        write!(f, "{s}")
    }
}

pub mod targets {
    use super::*;

    /// Nix's `aarch64-darwin` target.
    pub const AARCH64_DARWIN: Target = Target {
        arch: Architecture::Aarch64(Aarch64Architecture::Aarch64),
        os: OperatingSystem::Darwin,
    };

    /// Nix's `x86_64-darwin` target.
    pub const X86_64_DARWIN: Target = Target {
        arch: Architecture::X86_64,
        os: OperatingSystem::Darwin,
    };

    /// Nix's `aarch64-linux` target.
    pub const AARCH64_LINUX: Target = Target {
        arch: Architecture::Aarch64(Aarch64Architecture::Aarch64),
        os: OperatingSystem::Linux,
    };

    /// Nix's `x86_64-linux` target.
    pub const X86_64_LINUX: Target = Target {
        arch: Architecture::X86_64,
        os: OperatingSystem::Linux,
    };
}

impl Asset {
    pub fn to_nix_src(&self) -> Result<String> {
        let target = self.metadata.target.as_ref().map(|x| x.to_string());
        let name = self.metadata.name.as_ref();
        let version = self.metadata.version.as_ref().replace('.', "_");
        let url = &self.metadata.url;
        let sha256_digest = self
            .sha256_digest
            .as_ref()
            .context("missing sha256_digest")?
            .as_ref();

        let src = match target {
            Some(target) => formatdoc! {r#"
                bin.{target}.{name}-{version} = {{
                  url = "{url}";
                  sha256 = "{sha256_digest}";
                }};
                latest.bin.{target}.{name} = bin.{target}.{name}-{version};
            "#},
            // No target implies it's a source asset.
            None => formatdoc! {r#"
                src.{name}-{version} = {{
                  url = "{url}";
                  sha256 = "{sha256_digest}";
                }};
                latest.src.{name} = src.{name}-{version};
            "#},
        };

        Ok(src)
    }
}
