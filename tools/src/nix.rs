use target_lexicon::{Aarch64Architecture, Architecture, OperatingSystem};

#[derive(Debug, Copy, Clone, PartialEq, Eq)]
pub struct Target {
    pub arch: Architecture,
    pub os: OperatingSystem,
}

impl ToString for Target {
    fn to_string(&self) -> String {
        use targets::*;
        match *self {
            AARCH64_DARWIN => "aarch64-darwin",
            X86_64_DARWIN => "x86_64-darwin",
            AARCH64_LINUX => "aarch64-linux",
            X86_64_LINUX => "x86_64-linux",
            _ => unreachable!(),
        }
        .to_string()
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
