final: prev: let
  manifests = import ./manifests.nix;
  system = final.system;
  pkgs = final.pkgs;

  tarballs = builtins.listToAttrs (builtins.map
    (file: {
      name = file;
      value = builtins.fetchurl {
        url = manifests.${system}.${file}.url;
        sha256 = manifests.${system}.${file}.sha256;
      };
    })
    [
      "rust-esp"
      "rust-esp-src"
      "llvm-esp"
      "xtensa-esp32-elf"
      "xtensa-esp32s2-elf"
      "xtensa-esp32s3-elf"
      "riscv32-esp-elf"
    ]);
in {
  rust-bin-esp32 = pkgs.stdenv.mkDerivation {
    pname = "rust-bin-esp32";
    version = "1.69.0.0";
    dontUnpack = true;
    buildPhase = ''
      mkdir --parents $out tmp/{rust,rust-src} toolchains/esp/{\
      xtensa-esp32-elf-clang/esp-15.0.0-20221201,\
      xtensa-esp32s2-elf/esp-12.2.0_20230208,\
      xtensa-esp32-elf/esp-12.2.0_20230208,\
      xtensa-esp32s3-elf/esp-12.2.0_20230208,\
      riscv32-esp-elf/esp-12.2.0_20230208}

      tar --extract --file ${tarballs.rust-esp} --directory tmp/rust
      tar --extract --file ${tarballs.rust-esp-src} --directory tmp/rust-src
      tar --extract --file ${tarballs.llvm-esp} --directory toolchains/esp/xtensa-esp32-elf-clang/esp-15.0.0-20221201
      tar --extract --file ${tarballs.xtensa-esp32-elf} --directory toolchains/esp/xtensa-esp32-elf/esp-12.2.0_20230208
      tar --extract --file ${tarballs.xtensa-esp32s2-elf} --directory toolchains/esp/xtensa-esp32s2-elf/esp-12.2.0_20230208
      tar --extract --file ${tarballs.xtensa-esp32s3-elf} --directory toolchains/esp/xtensa-esp32s3-elf/esp-12.2.0_20230208
      tar --extract --file ${tarballs.riscv32-esp-elf} --directory toolchains/esp/riscv32-esp-elf/esp-12.2.0_20230208

      ./tmp/rust/rust-nightly-aarch64-apple-darwin/install.sh --destdir=toolchains/esp \
        --prefix="" --without=rust-docs-json-preview,rust-docs --disable-ldconfig
      ./tmp/rust-src/rust-src-nightly/install.sh --destdir=toolchains/esp --prefix="" --disable-ldconfig
      mv toolchains $out

      cat << 'EOF' > $out/env.sh
      export LIBCLANG_PATH="$out/toolchains/esp/xtensa-esp32-elf-clang/esp-15.0.0-20221201/esp-clang/lib"
      export PATH="$out/toolchains/esp/bin:$PATH"
      export PATH="$out/toolchains/esp/xtensa-esp32s3-elf/esp-12.2.0_20230208/xtensa-esp32s3-elf/bin:$PATH"
      export PATH="$out/toolchains/esp/riscv32-esp-elf/esp-12.2.0_20230208/riscv32-esp-elf/bin:$PATH"
      export PATH="$out/toolchains/esp/xtensa-esp32s2-elf/esp-12.2.0_20230208/xtensa-esp32s2-elf/bin:$PATH"
      export PATH="$out/toolchains/esp/xtensa-esp32-elf/esp-12.2.0_20230208/xtensa-esp32-elf/bin:$PATH"
      EOF
    '';
  };
}
