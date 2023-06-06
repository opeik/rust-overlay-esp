# Nix flake, see: https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachSystem ["x86_64-linux" "aarch64-darwin"] (
      system: let
        overlay = import ./overlay.nix;
        pkgs = import nixpkgs {
          inherit system;
          overlays = [overlay];
        };
      in {
        # `nix fmt`
        formatter = pkgs.alejandra;

        # `nix develop`
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Nix toolchain
            self.formatter.${system}
            nil
            # Rust toolchain
            rust-bin-esp
            ldproxy
            cargo-espflash
            cargo-espmonitor
            (lib.optional stdenv.isDarwin libiconv)
          ];
        };

        packages = {
          rust-bin-esp = pkgs.rust-bin-esp;
          ldproxy = pkgs.ldproxy;
        };
      }
    );
}
