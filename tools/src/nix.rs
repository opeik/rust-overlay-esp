use target_lexicon::{Aarch64Architecture, Architecture, OperatingSystem};

#[derive(Debug, Copy, Clone, PartialEq)]
pub struct Target {
    pub arch: Architecture,
    pub os: OperatingSystem,
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
