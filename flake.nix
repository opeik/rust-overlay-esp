# Nix flake, see: https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    rust-overlay,
    espup-src,
    embuild-src,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [(import rust-overlay)];
        };
      in {
        # `nix build`
        packages = {
          espup = pkgs.rustPlatform.buildRustPackage {
            pname = "espup";
            version = "0.4.1";
            src = espup-src;
            buildInputs = with pkgs; [openssl (with darwin.apple_sdk.frameworks; Security)];
            nativeBuildInputs = with pkgs; [pkg-config];
            doCheck = false;
            cargoHash = "sha256-GYhF6VDBAieZbu4x9EiQVVJkmx0aRYK0xwGGP0nuVGc=";
            OPENSSL_NO_VENDOR = 1;
          };

          ldproxy = pkgs.rustPlatform.buildRustPackage {
            pname = "ldproxy";
            version = "0.3.3";
            src = embuild-src;
            doCheck = false;
            cargoBuildFlags = "--package ldproxy";
            cargoHash = "sha256-2W5kKM0VV4C/L9dPxf4NDmi6VSleWvT27CfQbYCxo2U=";
          };

          rust-esp32 = let
            rust-base = pkgs.rust-bin.selectLatestNightlyWith (toolchain:
              toolchain.minimal.override {
                extensions = ["rust-src"];
                targets = ["riscv32imc-unknown-none-elf" "riscv32imac-unknown-none-elf"];
              });

            rust-esp = builtins.fetchurl {
              url = "https://github.com/esp-rs/rust-build/releases/download/v1.69.0.0/rust-1.69.0.0-aarch64-apple-darwin.tar.xz";
              sha256 = "1vrl9d56gsb5gjzkjn903k58hd8y3658j5ivgr0jd3klgh0s4x3v";
            };

            rust-esp-src = builtins.fetchurl {
              url = "https://github.com/esp-rs/rust-build/releases/download/v1.69.0.0/rust-src-1.69.0.0.tar.xz";
              sha256 = "1v30l5rn0zcra5x0xx802in67kpacywyvqjmn8v75h1walc3x3mg";
            };

            llvm-esp = builtins.fetchurl {
              url = "https://github.com/espressif/llvm-project/releases/download/esp-15.0.0-20221201/libs_llvm-esp-15.0.0-20221201-macos-arm64.tar.xz";
              sha256 = "18ak1hpr4w89h89p9qgxp48p9s0m7clb4mn84vp96bg0sv0b01hr";
            };

            xtensa-esp32-elf = builtins.fetchurl {
              url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/xtensa-esp32-elf-12.2.0_20230208-aarch64-apple-darwin.tar.xz";
              sha256 = "13nscn8h2jpzia0s2fyjmg871g2c895kwfriqmflgs8nnarcl2pm";
            };

            xtensa-esp32s2-elf = builtins.fetchurl {
              url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/xtensa-esp32s2-elf-12.2.0_20230208-aarch64-apple-darwin.tar.xz";
              sha256 = "1w06amk2kmiw2nr4llcl6x28gkdh8a3sl962hwvkraa3bz79gjfj";
            };

            xtensa-esp32s3-elf = builtins.fetchurl {
              url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/xtensa-esp32s3-elf-12.2.0_20230208-aarch64-apple-darwin.tar.xz";
              sha256 = "15bnxypbvy4lvf86qn2808si194i9sbgay1qibrgddn028z1m6mf";
            };

            riscv32-esp-elf = builtins.fetchurl {
              url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/riscv32-esp-elf-12.2.0_20230208-aarch64-apple-darwin.tar.xz";
              sha256 = "1yd30c98q8n15da2bzx5v4nfxrpyykjwyyzw25lpcn5jmx8l22kc";
            };
          in
            pkgs.stdenv.mkDerivation {
              pname = "rust-esp32";
              version = "1.69.0.0";
              dontUnpack = true;
              buildPhase = ''
                set -x

                mkdir --parents rust rust-src toolchains/esp
                cd toolchains/esp
                mkdir --parents \
                  xtensa-esp32-elf-clang/esp-15.0.0-20221201 \
                  xtensa-esp32s2-elf/esp-12.2.0_20230208 \
                  xtensa-esp32-elf/esp-12.2.0_20230208 \
                  xtensa-esp32s3-elf/esp-12.2.0_20230208 \
                  riscv32-esp-elf/esp-12.2.0_20230208
                cd ../..

                tar -xf ${llvm-esp} -C toolchains/esp/xtensa-esp32-elf-clang/esp-15.0.0-20221201
                tar -xf ${xtensa-esp32-elf} -C toolchains/esp/xtensa-esp32-elf/esp-12.2.0_20230208
                tar -xf ${xtensa-esp32s2-elf} -C toolchains/esp/xtensa-esp32s2-elf/esp-12.2.0_20230208
                tar -xf ${xtensa-esp32s3-elf} -C toolchains/esp/xtensa-esp32s3-elf/esp-12.2.0_20230208
                tar -xf ${riscv32-esp-elf} -C toolchains/esp/riscv32-esp-elf/esp-12.2.0_20230208

                tar -xf ${rust-esp} -C rust
                tar -xf ${rust-esp-src} -C rust-src

                rust/rust-nightly-aarch64-apple-darwin/install.sh --destdir=toolchains/esp \
                  --prefix="" --without=rust-docs-json-preview,rust-docs --disable-ldconfig
                rust-src/rust-src-nightly/install.sh --destdir=toolchains/esp --prefix="" --disable-ldconfig

                mkdir --parents $out/rustup
                mv toolchains $out/rustup

                set +x
              '';
            };
        };
        # `nix fmt`
        formatter = pkgs.alejandra;
        # `nix develop`
        devShells.default = pkgs.mkShell {
          buildInputs = [
            self.formatter.${system}
            pkgs.nil

            #self.packages.${system}.espup
            self.packages.${system}.ldproxy
            pkgs.cargo-espflash
            pkgs.cargo-espmonitor
            (pkgs.lib.optional pkgs.stdenv.isDarwin pkgs.libiconv)
            # pkgs.rustup
          ];
          shellHook = ''
            unset CC,CXX
            export RUSTUP_HOME="$(pwd)/.rustup"
          '';
        };
      }
    );
}
