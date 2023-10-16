rec {
  bin.aarch64-darwin.libs_llvm-esp-16_0_0-20230516 = {
    url = "https://github.com/espressif/llvm-project/releases/download/esp-16.0.0-20230516/libs_llvm-esp-16.0.0-20230516-macos-arm64.tar.xz";
    sha256 = "d97567af7d1197d636238378f95dc36a12145102c42f18d42ebdbaea0afbf02d";
  };
  latest.bin.aarch64-darwin.libs_llvm = bin.aarch64-darwin.libs_llvm-esp-16_0_0-20230516;
  bin.aarch64-linux.libs_llvm-esp-16_0_0-20230516 = {
    url = "https://github.com/espressif/llvm-project/releases/download/esp-16.0.0-20230516/libs_llvm-esp-16.0.0-20230516-linux-arm64.tar.xz";
    sha256 = "d2d906ce1352ee46c3b188f190880c53a5b31aedbd37d6c8effed384bfa8b837";
  };
  latest.bin.aarch64-linux.libs_llvm = bin.aarch64-linux.libs_llvm-esp-16_0_0-20230516;
  bin.x86_64-darwin.libs_llvm-esp-16_0_0-20230516 = {
    url = "https://github.com/espressif/llvm-project/releases/download/esp-16.0.0-20230516/libs_llvm-esp-16.0.0-20230516-macos.tar.xz";
    sha256 = "c6fde07d9c10d89efafc9b23796eb8636b45d71a6e6795cb4d0e0a292282f0a7";
  };
  latest.bin.x86_64-darwin.libs_llvm = bin.x86_64-darwin.libs_llvm-esp-16_0_0-20230516;
  bin.x86_64-linux.libs_llvm-esp-16_0_0-20230516 = {
    url = "https://github.com/espressif/llvm-project/releases/download/esp-16.0.0-20230516/libs_llvm-esp-16.0.0-20230516-linux-amd64.tar.xz";
    sha256 = "a80314f97dfb961789fac0ce6b5fdaac0791d681d842d84391fb6b5faf208970";
  };
  latest.bin.x86_64-linux.libs_llvm = bin.x86_64-linux.libs_llvm-esp-16_0_0-20230516;
  bin.aarch64-darwin.riscv32-esp-elf-13_2_0_20230928 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20230928/riscv32-esp-elf-13.2.0_20230928-aarch64-apple-darwin.tar.xz";
    sha256 = "c2f989370c101ae3f890aa71e6f57064f068f7c4a1d9f26445894c83f919624f";
  };
  latest.bin.aarch64-darwin.riscv32-esp-elf = bin.aarch64-darwin.riscv32-esp-elf-13_2_0_20230928;
  bin.aarch64-darwin.riscv32-esp-elf-13_2_0_20230928 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20230928/riscv32-esp-elf-13.2.0_20230928-aarch64-apple-darwin.tar.gz";
    sha256 = "3aa0c8f20475027d451a98eed45f3b19e1181b584fddbb12847bb9452b9b5a26";
  };
  latest.bin.aarch64-darwin.riscv32-esp-elf = bin.aarch64-darwin.riscv32-esp-elf-13_2_0_20230928;
  bin.aarch64-linux.riscv32-esp-elf-13_2_0_20230928 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20230928/riscv32-esp-elf-13.2.0_20230928-aarch64-linux-gnu.tar.gz";
    sha256 = "b0ce269901981ed97feba130ff583a9377e5e70cef06c616ca2a6686287d8de0";
  };
  latest.bin.aarch64-linux.riscv32-esp-elf = bin.aarch64-linux.riscv32-esp-elf-13_2_0_20230928;
  bin.aarch64-linux.riscv32-esp-elf-13_2_0_20230928 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20230928/riscv32-esp-elf-13.2.0_20230928-aarch64-linux-gnu.tar.xz";
    sha256 = "6ee4b30dff18bdea9ada79399c0c81ba82b6ed99a565746a7d5040c7e62566b3";
  };
  latest.bin.aarch64-linux.riscv32-esp-elf = bin.aarch64-linux.riscv32-esp-elf-13_2_0_20230928;
  bin.x86_64-darwin.riscv32-esp-elf-13_2_0_20230928 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20230928/riscv32-esp-elf-13.2.0_20230928-x86_64-apple-darwin.tar.gz";
    sha256 = "fac2c797fa8265bfec1f0337676ecc00fec124c036b15f1ec8003e26d7287688";
  };
  latest.bin.x86_64-darwin.riscv32-esp-elf = bin.x86_64-darwin.riscv32-esp-elf-13_2_0_20230928;
  bin.x86_64-darwin.riscv32-esp-elf-13_2_0_20230928 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20230928/riscv32-esp-elf-13.2.0_20230928-x86_64-apple-darwin.tar.xz";
    sha256 = "ce40c75a1ae0e4b986daeeff321aaa7b57f74eb4bcfd011f1252fd6932bbb90f";
  };
  latest.bin.x86_64-darwin.riscv32-esp-elf = bin.x86_64-darwin.riscv32-esp-elf-13_2_0_20230928;
  bin.x86_64-linux.riscv32-esp-elf-13_2_0_20230928 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20230928/riscv32-esp-elf-13.2.0_20230928-x86_64-linux-gnu.tar.xz";
    sha256 = "782feefe354500c5f968e8c91959651be3bdbbd7ae8a17affcee2b1bffcaad89";
  };
  latest.bin.x86_64-linux.riscv32-esp-elf = bin.x86_64-linux.riscv32-esp-elf-13_2_0_20230928;
  bin.x86_64-linux.riscv32-esp-elf-13_2_0_20230928 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20230928/riscv32-esp-elf-13.2.0_20230928-x86_64-linux-gnu.tar.gz";
    sha256 = "7d8c46828385212af66e18f9a1391be4d2f8d320075e7c9d9e11a3420d680dc0";
  };
  latest.bin.x86_64-linux.riscv32-esp-elf = bin.x86_64-linux.riscv32-esp-elf-13_2_0_20230928;
  bin.aarch64-darwin.rust-1_73_0_0 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.73.0.0/rust-1.73.0.0-aarch64-apple-darwin.tar.xz";
    sha256 = "2f1d6ec5f610efa276e6ff195575eeb75551712d5dfabc518844ca00d3d52e73";
  };
  latest.bin.aarch64-darwin.rust = bin.aarch64-darwin.rust-1_73_0_0;
  bin.aarch64-linux.rust-1_73_0_0 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.73.0.0/rust-1.73.0.0-aarch64-unknown-linux-gnu.tar.xz";
    sha256 = "29aff8fbac45b75d10e521aa32e77540857a8730e5e1e013465e95e716b84582";
  };
  latest.bin.aarch64-linux.rust = bin.aarch64-linux.rust-1_73_0_0;
  bin.x86_64-darwin.rust-1_73_0_0 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.73.0.0/rust-1.73.0.0-x86_64-apple-darwin.tar.xz";
    sha256 = "4b2dc159a9d98f88f59a0a5cbcef3591c5b7bd6305124cfb587298978f8db0b1";
  };
  latest.bin.x86_64-darwin.rust = bin.x86_64-darwin.rust-1_73_0_0;
  bin.x86_64-linux.rust-1_73_0_0 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.73.0.0/rust-1.73.0.0-x86_64-unknown-linux-gnu.tar.xz";
    sha256 = "232daefd21204103e3d1420b9bbbf719aed14e9ff0b329d6d2c85b8b06b77f15";
  };
  latest.bin.x86_64-linux.rust = bin.x86_64-linux.rust-1_73_0_0;
  src.rust-src-1_73_0_0 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.73.0.0/rust-src-1.73.0.0.tar.xz";
    sha256 = "3f5b96096564a13879b8b8c3ac074b13afe0e960ec13143249228aaf7242f720";
  };
  latest.src.rust-src = src.rust-src-1_73_0_0;
  bin.aarch64-darwin.xtensa-esp-elf-13_2_0_20230928 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20230928/xtensa-esp-elf-13.2.0_20230928-aarch64-apple-darwin.tar.xz";
    sha256 = "687243e5cbefb7cf05603effbdd6fde5769f94daff7e519f5bbe61f43c4c0ef6";
  };
  latest.bin.aarch64-darwin.xtensa-esp-elf = bin.aarch64-darwin.xtensa-esp-elf-13_2_0_20230928;
  bin.aarch64-darwin.xtensa-esp-elf-13_2_0_20230928 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20230928/xtensa-esp-elf-13.2.0_20230928-aarch64-apple-darwin.tar.gz";
    sha256 = "7ffad9326fa1f5d2b0a8819043050695010be72e0c91899230491beae6540015";
  };
  latest.bin.aarch64-darwin.xtensa-esp-elf = bin.aarch64-darwin.xtensa-esp-elf-13_2_0_20230928;
  bin.aarch64-linux.xtensa-esp-elf-13_2_0_20230928 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20230928/xtensa-esp-elf-13.2.0_20230928-aarch64-linux-gnu.tar.xz";
    sha256 = "faa4755bedafb1c10feaeef01c610803ee9ace088b26d7db90a5ee0816c20f9e";
  };
  latest.bin.aarch64-linux.xtensa-esp-elf = bin.aarch64-linux.xtensa-esp-elf-13_2_0_20230928;
  bin.aarch64-linux.xtensa-esp-elf-13_2_0_20230928 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20230928/xtensa-esp-elf-13.2.0_20230928-aarch64-linux-gnu.tar.gz";
    sha256 = "cf649f02f36463cdea7d2e213ce461cf0926bb4e1243c0a07971650d6150bcea";
  };
  latest.bin.aarch64-linux.xtensa-esp-elf = bin.aarch64-linux.xtensa-esp-elf-13_2_0_20230928;
  bin.x86_64-darwin.xtensa-esp-elf-13_2_0_20230928 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20230928/xtensa-esp-elf-13.2.0_20230928-x86_64-apple-darwin.tar.gz";
    sha256 = "13716f49824d1429bf7cccbad45befb79adf1df7d2310c83e9457f4fddb12922";
  };
  latest.bin.x86_64-darwin.xtensa-esp-elf = bin.x86_64-darwin.xtensa-esp-elf-13_2_0_20230928;
  bin.x86_64-darwin.xtensa-esp-elf-13_2_0_20230928 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20230928/xtensa-esp-elf-13.2.0_20230928-x86_64-apple-darwin.tar.xz";
    sha256 = "b9b7a6d1dc4ea065bf6763fa904729e1c808d6dfbf1dfabf12852e2929251ee9";
  };
  latest.bin.x86_64-darwin.xtensa-esp-elf = bin.x86_64-darwin.xtensa-esp-elf-13_2_0_20230928;
  bin.x86_64-linux.xtensa-esp-elf-13_2_0_20230928 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20230928/xtensa-esp-elf-13.2.0_20230928-x86_64-linux-gnu.tar.xz";
    sha256 = "bae7da23ea8516fb7e42640f4420c4dd1ebfd64189a14fc330d73e173b3a038b";
  };
  latest.bin.x86_64-linux.xtensa-esp-elf = bin.x86_64-linux.xtensa-esp-elf-13_2_0_20230928;
  bin.x86_64-linux.xtensa-esp-elf-13_2_0_20230928 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20230928/xtensa-esp-elf-13.2.0_20230928-x86_64-linux-gnu.tar.gz";
    sha256 = "846238d8dcfa42ad492c39dbb4cdea0418fccd1f9130e180c5498cb66ba2ffb6";
  };
  latest.bin.x86_64-linux.xtensa-esp-elf = bin.x86_64-linux.xtensa-esp-elf-13_2_0_20230928;
}
