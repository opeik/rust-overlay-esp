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
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    rust-overlay,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [(import rust-overlay) (import ./nix/overlay.nix)];
        };
      in {
        # `nix fmt`
        formatter = pkgs.alejandra;

        # `nix develop`
        devShells.default = let
          nix-tools = with pkgs; [nil self.formatter.${system}];
          rust-tools = with pkgs; [
            #rust-bin-esp32
            pkgs.ldproxy
            cargo-espflash
            cargo-espmonitor
            (lib.optional stdenv.isDarwin libiconv)
          ];
        in
          pkgs.mkShell {
            buildInputs = [nix-tools rust-tools];
            shellHook = with pkgs; ''
              unset CC CXX
            '';
          };
      }
    );
}
