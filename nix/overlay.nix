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
  in
    pkgs.stdenv.mkDerivation {
      pname = "rust-bin-esp32";
      version = "1.69.0.0";
      dontUnpack = true;
      buildInputs = [pkgs.makeWrapper];
      buildPhase = ''
        mkdir --parents rust rust-src esp/{\
        xtensa-esp32-elf-clang/esp-15.0.0-20221201,\
        xtensa-esp32s2-elf/esp-12.2.0_20230208,\
        xtensa-esp32-elf/esp-12.2.0_20230208,\
        xtensa-esp32s3-elf/esp-12.2.0_20230208,\
        riscv32-esp-elf/esp-12.2.0_20230208}

        tar --extract --file ${bins.rust-esp} --directory rust
        tar --extract --file ${bins.rust-esp-src} --directory rust-src
        tar --extract --file ${bins.llvm-esp} --directory esp/xtensa-esp32-elf-clang/esp-15.0.0-20221201
        tar --extract --file ${bins.xtensa-esp32-elf} --directory esp/xtensa-esp32-elf/esp-12.2.0_20230208
        tar --extract --file ${bins.xtensa-esp32s2-elf} --directory esp/xtensa-esp32s2-elf/esp-12.2.0_20230208
        tar --extract --file ${bins.xtensa-esp32s3-elf} --directory esp/xtensa-esp32s3-elf/esp-12.2.0_20230208
        tar --extract --file ${bins.riscv32-esp-elf} --directory esp/riscv32-esp-elf/esp-12.2.0_20230208

        ./rust/rust-nightly-aarch64-apple-darwin/install.sh --destdir=esp \
          --prefix="" --without=rust-docs-json-preview,rust-docs --disable-ldconfig
        ./rust-src/rust-src-nightly/install.sh --destdir=esp --prefix="" --disable-ldconfig
      '';

      installPhase = ''
        mkdir --parents $out/bin
        mv esp $out

        ln --symbolic $out/esp/{\
        xtensa-esp32-elf/esp-12.2.0_20230208/xtensa-esp32-elf/bin/*,\
        xtensa-esp32s2-elf/esp-12.2.0_20230208/xtensa-esp32s2-elf/bin/*,\
        xtensa-esp32s3-elf/esp-12.2.0_20230208/xtensa-esp32s3-elf/bin/*,\
        riscv32-esp-elf/esp-12.2.0_20230208/riscv32-esp-elf/bin/*} $out/bin

        # See: https://github.com/ivmarkov/rust-esp32-std-demo/issues/129
        for file in $out/esp/bin/*; do
          wrapProgram $file \
            --unset CC \
            --unset CXX \
            --set LIBCLANG_PATH "$out/esp/xtensa-esp32-elf-clang/esp-15.0.0-20221201/esp-clang/lib"
          ln --symbolic $file $out/bin
        done
      '';
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
