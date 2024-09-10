# `rust-overlay-esp`

[![.github/workflows/ci.yml](https://github.com/opeik/rust-overlay-esp/actions/workflows/ci.yml/badge.svg)](https://github.com/opeik/rust-overlay-esp/actions/workflows/ci.yml)

## Usage

### CLI
`nix shell github:opeik/rust-overlay-esp` then cry and buy an Raspberry Pi Pico.

### Flake
```nix
# Nix flake, see: https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay-esp = {
      url = "github:opeik/rust-overlay-esp";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    rust-overlay-esp,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        # `nix develop`
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Rust toolchain
            rust-overlay-esp.packages.${system}.rust-bin-esp
            (lib.optional stdenv.isDarwin [libiconv])
          ];
        };
      }
    );
}
```

## License

Licensed under either of

- Apache License, Version 2.0
  ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
- MIT license
  ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

at your option.

## Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall be
dual licensed as above, without any additional terms or conditions.
