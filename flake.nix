# Nix flake, see: https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    rust-overlay,
    ...
  }:
    flake-utils.lib.eachSystem ["aarch64-darwin" "x86_64-darwin" "aarch64-linux" "x86_64-linux"] (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [(import ./overlay.nix) (import rust-overlay)];
        };
      in {
        # `nix fmt`
        formatter = pkgs.alejandra;

        # `nix develop`
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Nix toolchain
            self.formatter.${system}
            nil
            # Rust toolchain
            (rust-bin.fromRustupToolchainFile ./rust-toolchain.toml)
            (
              lib.optional stdenv.isDarwin [
                libiconv
                (with darwin.apple_sdk.frameworks; [Security SystemConfiguration])
              ]
            )
          ];
        };

        packages = {
          default = self.packages.${system}.rust-bin-esp;
          rust-bin-esp = pkgs.rust-bin-esp;
          ldproxy = pkgs.ldproxy;
        };
      }
    );
}
