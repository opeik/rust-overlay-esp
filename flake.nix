# Nix flake, see: https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    espup-src = {
      flake = false;
      url = "github:esp-rs/espup/v0.4.1";
    };
    embuild-src = {
      flake = false;
      url = "github:esp-rs/embuild/v0.31.2";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    espup-src,
    embuild-src,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        {
          # `nix build`
          packages = {
            espup = pkgs.rustPlatform.buildRustPackage {
              pname = "espup";
              version = "0.4.1";
              src = espup-src;
              buildInputs = with pkgs; [ openssl darwin.apple_sdk.frameworks.Security ];
              nativeBuildInputs = with pkgs; [ pkg-config ];
              doCheck = false;
              cargoHash = "sha256-GYhF6VDBAieZbu4x9EiQVVJkmx0aRYK0xwGGP0nuVGc=";
              OPENSSL_NO_VENDOR = 1;
            };

            ldproxy = pkgs.rustPlatform.buildRustPackage {
              pname = "ldproxy";
              version = "0.3.3";
              src = embuild-src;
              cargoBuildFlags = "--package ldproxy";
              doCheck = false;
              cargoHash = "sha256-2W5kKM0VV4C/L9dPxf4NDmi6VSleWvT27CfQbYCxo2U=";
            };
          };
          # `nix fmt`
          formatter = pkgs.alejandra;
          # `nix develop`
          devShells.default = pkgs.mkShell {
            buildInputs = [
              self.formatter.${system}
              self.packages.${system}.espup
              self.packages.${system}.ldproxy
              pkgs.cargo-espflash
              pkgs.cargo-espmonitor
              pkgs.rustup
              (pkgs.lib.optional pkgs.stdenv.isDarwin pkgs.libiconv)
            ];
            shellHook = ''
              export RUSTUP_HOME="$(pwd)/.rustup"
            '';
          };
        }
    );
}
