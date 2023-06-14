rec {
  src.rust-src-1_70_0_1 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.70.0.1/rust-src-1.70.0.1.tar.xz";
    sha256 = "cf411534a7114da33752d9b42254a4653638b098bf90dd7b920dd1f39f00f94e";
  };
  latest.src.rust-src = src.rust-src-1_70_0_1;
  bin.aarch64-darwin.rust-1_70_0_1 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.70.0.1/rust-1.70.0.1-aarch64-apple-darwin.tar.xz";
    sha256 = "36194ed6ab07b74450e75153d15500d01542acb6262c8a66329252c1b089f08f";
  };
  latest.bin.aarch64-darwin.rust = bin.aarch64-darwin.rust-1_70_0_1;
  bin.aarch64-linux.rust-1_70_0_1 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.70.0.1/rust-1.70.0.1-aarch64-unknown-linux-gnu.tar.xz";
    sha256 = "1aec250a44029e74786be6cff93ff1111d9f25d64734b13f96c623cd4a898485";
  };
  latest.bin.aarch64-linux.rust = bin.aarch64-linux.rust-1_70_0_1;
  bin.x86_64-darwin.rust-1_70_0_1 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.70.0.1/rust-1.70.0.1-x86_64-apple-darwin.tar.xz";
    sha256 = "2dd4a26b8fa4a2917fb118ba6dbd700e990943323ab1d42296b847423e53a8e5";
  };
  latest.bin.x86_64-darwin.rust = bin.x86_64-darwin.rust-1_70_0_1;
  bin.x86_64-linux.rust-1_70_0_1 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.70.0.1/rust-1.70.0.1-x86_64-unknown-linux-gnu.tar.xz";
    sha256 = "d66f540b5c483f8e190aeea8fc4695546b55092467ee2b1ca679bd6c6102ec6d";
  };
  latest.bin.x86_64-linux.rust = bin.x86_64-linux.rust-1_70_0_1;
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
  bin.aarch64-darwin.riscv32-esp-elf-12_2_0_20230208 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/riscv32-esp-elf-12.2.0_20230208-aarch64-apple-darwin.tar.xz";
    sha256 = "6c0a4151afb258766911fc7bcfe5f4fee6ee2cd9a5ff25542bc1228c1203a3f9";
  };
  latest.bin.aarch64-darwin.riscv32-esp-elf = bin.aarch64-darwin.riscv32-esp-elf-12_2_0_20230208;
  bin.aarch64-darwin.xtensa-esp32-elf-12_2_0_20230208 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/xtensa-esp32-elf-12.2.0_20230208-aarch64-apple-darwin.tar.xz";
    sha256 = "f50acab2b216e9475dc5313b3e4b424cbc70d0abd23ba1818aff4a019165da8e";
  };
  latest.bin.aarch64-darwin.xtensa-esp32-elf = bin.aarch64-darwin.xtensa-esp32-elf-12_2_0_20230208;
  bin.aarch64-darwin.xtensa-esp32s2-elf-12_2_0_20230208 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/xtensa-esp32s2-elf-12.2.0_20230208-aarch64-apple-darwin.tar.xz";
    sha256 = "d2c997ce5f43a93c3787c224aa8742b0cd87443794514ab2153cd629665506f0";
  };
  latest.bin.aarch64-darwin.xtensa-esp32s2-elf = bin.aarch64-darwin.xtensa-esp32s2-elf-12_2_0_20230208;
  bin.aarch64-darwin.xtensa-esp32s3-elf-12_2_0_20230208 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/xtensa-esp32s3-elf-12.2.0_20230208-aarch64-apple-darwin.tar.xz";
    sha256 = "ae9a1a3e12c0b6f6f28a3878f5964e91a410350248586c90db94f8bdaeef7695";
  };
  latest.bin.aarch64-darwin.xtensa-esp32s3-elf = bin.aarch64-darwin.xtensa-esp32s3-elf-12_2_0_20230208;
  bin.aarch64-linux.riscv32-esp-elf-12_2_0_20230208 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/riscv32-esp-elf-12.2.0_20230208-aarch64-linux-gnu.tar.xz";
    sha256 = "aefbf1e6f2c91a10e8995399d2003502e167e8c95e77f40957309e843700906a";
  };
  latest.bin.aarch64-linux.riscv32-esp-elf = bin.aarch64-linux.riscv32-esp-elf-12_2_0_20230208;
  bin.aarch64-linux.xtensa-esp32-elf-12_2_0_20230208 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/xtensa-esp32-elf-12.2.0_20230208-aarch64-linux-gnu.tar.xz";
    sha256 = "9e211a182b6ea0396a41c78f52f51d964e7875fe274ea9c81111bf0dbc90c516";
  };
  latest.bin.aarch64-linux.xtensa-esp32-elf = bin.aarch64-linux.xtensa-esp32-elf-12_2_0_20230208;
  bin.aarch64-linux.xtensa-esp32s2-elf-12_2_0_20230208 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/xtensa-esp32s2-elf-12.2.0_20230208-aarch64-linux-gnu.tar.xz";
    sha256 = "48e88053e92bab1bf8d6dbad7ddb4d140c537159d607a36e73e74e1f5f23c892";
  };
  latest.bin.aarch64-linux.xtensa-esp32s2-elf = bin.aarch64-linux.xtensa-esp32s2-elf-12_2_0_20230208;
  bin.aarch64-linux.xtensa-esp32s3-elf-12_2_0_20230208 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/xtensa-esp32s3-elf-12.2.0_20230208-aarch64-linux-gnu.tar.xz";
    sha256 = "30a1fed3ab6341feb1ae986ee55f227df6a594293ced13c65a0136eb4681087d";
  };
  latest.bin.aarch64-linux.xtensa-esp32s3-elf = bin.aarch64-linux.xtensa-esp32s3-elf-12_2_0_20230208;
  bin.x86_64-darwin.riscv32-esp-elf-12_2_0_20230208 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/riscv32-esp-elf-12.2.0_20230208-x86_64-apple-darwin.tar.xz";
    sha256 = "78cd1afe458fceb7c2657fe346edb0ecfde3b8743ccf7a7a7509c456cad9de9a";
  };
  latest.bin.x86_64-darwin.riscv32-esp-elf = bin.x86_64-darwin.riscv32-esp-elf-12_2_0_20230208;
  bin.x86_64-darwin.xtensa-esp32-elf-12_2_0_20230208 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/xtensa-esp32-elf-12.2.0_20230208-x86_64-apple-darwin.tar.xz";
    sha256 = "b09d87fdb1dc32cd1d718935065ef931b101a14df6b17be56748e52640955bff";
  };
  latest.bin.x86_64-darwin.xtensa-esp32-elf = bin.x86_64-darwin.xtensa-esp32-elf-12_2_0_20230208;
  bin.x86_64-darwin.xtensa-esp32s2-elf-12_2_0_20230208 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/xtensa-esp32s2-elf-12.2.0_20230208-x86_64-apple-darwin.tar.xz";
    sha256 = "e7b2fbacd8186b24d1b1264ad6cf639f476d51f5d908fb79504abfe6281d3c8c";
  };
  latest.bin.x86_64-darwin.xtensa-esp32s2-elf = bin.x86_64-darwin.xtensa-esp32s2-elf-12_2_0_20230208;
  bin.x86_64-darwin.xtensa-esp32s3-elf-12_2_0_20230208 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/xtensa-esp32s3-elf-12.2.0_20230208-x86_64-apple-darwin.tar.xz";
    sha256 = "30375231847a9070e4e0acb3102b7d35a60448a55536bfa113c677c449da3eef";
  };
  latest.bin.x86_64-darwin.xtensa-esp32s3-elf = bin.x86_64-darwin.xtensa-esp32s3-elf-12_2_0_20230208;
  bin.x86_64-linux.riscv32-esp-elf-12_2_0_20230208 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/riscv32-esp-elf-12.2.0_20230208-x86_64-linux-gnu.tar.xz";
    sha256 = "21694e5ee506f5e52908b12c6b5be7044d87cf34bb4dfcd151d0a10ea09dedc1";
  };
  latest.bin.x86_64-linux.riscv32-esp-elf = bin.x86_64-linux.riscv32-esp-elf-12_2_0_20230208;
  bin.x86_64-linux.xtensa-esp32-elf-12_2_0_20230208 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/xtensa-esp32-elf-12.2.0_20230208-x86_64-linux-gnu.tar.xz";
    sha256 = "4d2e02ef47f1a93a4dcfdbaecd486adfaab4c0e26deea2c18d6385527f39f864";
  };
  latest.bin.x86_64-linux.xtensa-esp32-elf = bin.x86_64-linux.xtensa-esp32-elf-12_2_0_20230208;
  bin.x86_64-linux.xtensa-esp32s2-elf-12_2_0_20230208 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/xtensa-esp32s2-elf-12.2.0_20230208-x86_64-linux-gnu.tar.xz";
    sha256 = "a1bd8f0252aae02cff2c289f742fbdbaa2c24644cc30e883d118253ea4df1799";
  };
  latest.bin.x86_64-linux.xtensa-esp32s2-elf = bin.x86_64-linux.xtensa-esp32s2-elf-12_2_0_20230208;
  bin.x86_64-linux.xtensa-esp32s3-elf-12_2_0_20230208 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/xtensa-esp32s3-elf-12.2.0_20230208-x86_64-linux-gnu.tar.xz";
    sha256 = "29b5ea6b30d98231f0c17f2327404109e0abf59b48d0f2890d9d9899678a89a3";
  };
  latest.bin.x86_64-linux.xtensa-esp32s3-elf = bin.x86_64-linux.xtensa-esp32s3-elf-12_2_0_20230208;
}
