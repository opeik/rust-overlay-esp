final: prev: let
  pkgs = final.pkgs;
  system = final.system;
in {
  rust-bin-esp = let
    manifests = import ./manifests.nix;

    srcs = let
      assets = manifests.latest.src;
    in
      builtins.listToAttrs (builtins.map
        (name: {
          name = name;
          value = builtins.fetchurl {
            url = assets.${name}.url;
            sha256 = assets.${name}.sha256;
          };
        })
        (builtins.attrNames assets));

    bins = let
      assets = manifests.latest.bin.${system};
    in
      builtins.listToAttrs (builtins.map
        (name: {
          name = name;
          value = builtins.fetchurl {
            url = assets.${name}.url;
            sha256 = assets.${name}.sha256;
          };
        })
        (builtins.attrNames assets));
  in let
    llvm-version = builtins.head (builtins.match ''.+esp-(.+)-.+-.+\..+'' (builtins.baseNameOf bins.libs-clang-esp));
    esp-version = builtins.head (builtins.match ''.+xtensa-esp-elf-(.+)-.+-.+-.+\..+'' (builtins.baseNameOf bins.xtensa-esp-elf));
  in
    pkgs.stdenv.mkDerivation {
      pname = "rust-bin-esp";
      version = esp-version;
      dontUnpack = true;
      buildInputs = with pkgs; [makeWrapper patchelf];
      buildPhase = with bins;
      with srcs; ''
        mkdir --parents rust rust-src esp/{\
        xtensa-esp32-elf-clang/esp-${llvm-version},\
        xtensa-esp32s2-elf/esp-${esp-version},\
        xtensa-esp32-elf/esp-${esp-version},\
        xtensa-esp32s3-elf/esp-${esp-version},\
        riscv32-esp-elf/esp-${esp-version}}

        tar --extract --file ${rust} --directory rust
        tar --extract --file ${rust-src} --directory rust-src
        tar --extract --file ${libs-clang-esp} --directory esp/xtensa-esp32-elf-clang/esp-${llvm-version}
        tar --extract --file ${xtensa-esp32-elf} --directory esp/xtensa-esp32-elf/esp-${esp-version}
        tar --extract --file ${xtensa-esp32s2-elf} --directory esp/xtensa-esp32s2-elf/esp-${esp-version}
        tar --extract --file ${xtensa-esp32s3-elf} --directory esp/xtensa-esp32s3-elf/esp-${esp-version}
        tar --extract --file ${riscv32-esp-elf} --directory esp/riscv32-esp-elf/esp-${esp-version}

        ./rust/rust-nightly-aarch64-apple-darwin/install.sh --destdir=esp \
          --prefix="" --without=rust-docs-json-preview,rust-docs --disable-ldconfig
        ./rust-src/rust-src-nightly/install.sh --destdir=esp --prefix="" --disable-ldconfig
      '';

      installPhase = ''
        mkdir --parents $out/bin
        mv esp $out

        ln --symbolic $out/esp/{\
        xtensa-esp32-elf/esp-${esp-version}/xtensa-esp32-elf/bin/*,\
        xtensa-esp32s2-elf/esp-${esp-version}/xtensa-esp32s2-elf/bin/*,\
        xtensa-esp32s3-elf/esp-${esp-version}/xtensa-esp32s3-elf/bin/*,\
        riscv32-esp-elf/esp-${esp-version}/riscv32-esp-elf/bin/*} $out/bin

        # See: https://github.com/ivmarkov/rust-esp32-std-demo/issues/129
        for file in $out/esp/bin/*; do
          wrapProgram $file \
            --unset CC \
            --unset CXX \
            --set LIBCLANG_PATH "$out/esp/xtensa-esp32-elf-clang/esp-${llvm-version}/esp-clang/lib"
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
