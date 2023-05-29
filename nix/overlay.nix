final: prev: let
  pkgs = final.pkgs;
  system = final.system;
in {
  rust-bin-esp32 = let
    manifests = import ./manifests.nix;
    bins = builtins.listToAttrs (builtins.map
      (file: {
        name = file;
        value = builtins.fetchurl {
          url = manifests.${system}.${file}.url;
          sha256 = manifests.${system}.${file}.sha256;
        };
      })
      (builtins.attrNames manifests.${system}));
  in {
    rust-bin-esp32 = pkgs.stdenv.mkDerivation {
      pname = "rust-bin-esp32";
      version = "1.69.0.0";
      dontUnpack = true;
      buildPhase = ''
        mkdir --parents $out tmp/{rust,rust-src} esp/{\
        xtensa-esp32-elf-clang/esp-15.0.0-20221201,\
        xtensa-esp32s2-elf/esp-12.2.0_20230208,\
        xtensa-esp32-elf/esp-12.2.0_20230208,\
        xtensa-esp32s3-elf/esp-12.2.0_20230208,\
        riscv32-esp-elf/esp-12.2.0_20230208}

        tar --extract --file ${bins.rust-esp} --directory tmp/rust
        tar --extract --file ${bins.rust-esp-src} --directory tmp/rust-src
        tar --extract --file ${bins.llvm-esp} --directory esp/xtensa-esp32-elf-clang/esp-15.0.0-20221201
        tar --extract --file ${bins.xtensa-esp32-elf} --directory esp/xtensa-esp32-elf/esp-12.2.0_20230208
        tar --extract --file ${bins.xtensa-esp32s2-elf} --directory esp/xtensa-esp32s2-elf/esp-12.2.0_20230208
        tar --extract --file ${bins.xtensa-esp32s3-elf} --directory esp/xtensa-esp32s3-elf/esp-12.2.0_20230208
        tar --extract --file ${bins.riscv32-esp-elf} --directory esp/riscv32-esp-elf/esp-12.2.0_20230208

        ./tmp/rust/rust-nightly-aarch64-apple-darwin/install.sh --destdir=esp \
          --prefix="" --without=rust-docs-json-preview,rust-docs --disable-ldconfig
        ./tmp/rust-src/rust-src-nightly/install.sh --destdir=esp --prefix="" --disable-ldconfig
        mv esp $out

        cat << 'EOF' > $out/env.sh
        export LIBCLANG_PATH="$out/esp/xtensa-esp32-elf-clang/esp-15.0.0-20221201/esp-clang/lib"
        export PATH="$out/esp/bin:$PATH"
        export PATH="$out/esp/xtensa-esp32s3-elf/esp-12.2.0_20230208/xtensa-esp32s3-elf/bin:$PATH"
        export PATH="$out/esp/riscv32-esp-elf/esp-12.2.0_20230208/riscv32-esp-elf/bin:$PATH"
        export PATH="$out/esp/xtensa-esp32s2-elf/esp-12.2.0_20230208/xtensa-esp32s2-elf/bin:$PATH"
        export PATH="$out/esp/xtensa-esp32-elf/esp-12.2.0_20230208/xtensa-esp32-elf/bin:$PATH"
        EOF
        substituteInPlace $out/env.sh --replace '$out' "$out"
      '';
    };
  };

  ldproxy = pkgs.rustPlatform.buildRustPackage {
    pname = "ldproxy";
    version = "0.3.3";
    src = builtins.fetchGit {
      url = "https://github.com/esp-rs/embuild.git";
      ref = "refs/tags/v0.31.2";
      rev = "2ec3bbc91cd3a4fda54e02c9f1bc6dc350a957b2";
    };
    doCheck = false;
    cargoBuildFlags = "--package ldproxy";
    cargoHash = "sha256-2W5kKM0VV4C/L9dPxf4NDmi6VSleWvT27CfQbYCxo2U=";
  };
}
