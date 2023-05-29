# Nix flake, see: https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
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
    rust-overlay,
    embuild-src,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [(import rust-overlay) (import ./nix/overlay.nix)];
        };
      in {
        # `nix build`
        packages = {
          ldproxy = pkgs.rustPlatform.buildRustPackage {
            pname = "ldproxy";
            version = "0.3.3";
            src = embuild-src;
            doCheck = false;
            cargoBuildFlags = "--package ldproxy";
            cargoHash = "sha256-2W5kKM0VV4C/L9dPxf4NDmi6VSleWvT27CfQbYCxo2U=";
          };
        };
        # `nix fmt`
        formatter = pkgs.alejandra;
        # `nix develop`

        devShells.default = let
          # rust-base = pkgs.rust-bin.selectLatestNightlyWith (toolchain:
          #   toolchain.minimal.override {
          #     extensions = ["rust-src"];
          #     targets = ["riscv32imc-unknown-none-elf" "riscv32imac-unknown-none-elf"];
          #   });
          nix-tools = with pkgs; [nil self.formatter.${system}];
          rust-tools = with pkgs; [
            rust-bin-esp32
            cargo-espflash
            cargo-espmonitor
            self.packages.${system}.ldproxy
            (lib.optional stdenv.isDarwin libiconv)
          ];
        in
          pkgs.mkShell {
            buildInputs = [nix-tools rust-tools];
            shellHook = with pkgs; ''
              unset CC CXX
              source ${rust-bin-esp32}/env.sh
            '';
          };
      }
    );
}
