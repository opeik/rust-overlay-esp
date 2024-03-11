rec {
  bin.aarch64-darwin.libs_llvm-esp-16_0_4-20231113 = {
    url = "https://github.com/espressif/llvm-project/releases/download/esp-16.0.4-20231113/libs_llvm-esp-16.0.4-20231113-macos-arm64.tar.xz";
    sha256 = "3b4dc31c716ec5d27235a48bd9580683bd7478e43226a4ef63c6a0e3a8a22723";
  };
  latest.bin.aarch64-darwin.libs_llvm = bin.aarch64-darwin.libs_llvm-esp-16_0_4-20231113;
  bin.aarch64-linux.libs_llvm-esp-16_0_4-20231113 = {
    url = "https://github.com/espressif/llvm-project/releases/download/esp-16.0.4-20231113/libs_llvm-esp-16.0.4-20231113-linux-arm64.tar.xz";
    sha256 = "574f1bd9b2706eedb05926c757ff204b4b753dfc61dec7f9708fef42f384ecac";
  };
  latest.bin.aarch64-linux.libs_llvm = bin.aarch64-linux.libs_llvm-esp-16_0_4-20231113;
  bin.x86_64-darwin.libs_llvm-esp-16_0_4-20231113 = {
    url = "https://github.com/espressif/llvm-project/releases/download/esp-16.0.4-20231113/libs_llvm-esp-16.0.4-20231113-macos.tar.xz";
    sha256 = "a1a4396a2ed6a58b18b84cffdbb86f71b2c8edf0d749c81690ffd4a2725fa788";
  };
  latest.bin.x86_64-darwin.libs_llvm = bin.x86_64-darwin.libs_llvm-esp-16_0_4-20231113;
  bin.x86_64-linux.libs_llvm-esp-16_0_4-20231113 = {
    url = "https://github.com/espressif/llvm-project/releases/download/esp-16.0.4-20231113/libs_llvm-esp-16.0.4-20231113-linux-amd64.tar.xz";
    sha256 = "f98b1c1d2f12ed7776f098aaf62d6671add14cfb30a0a746764af4b6adadccdf";
  };
  latest.bin.x86_64-linux.libs_llvm = bin.x86_64-linux.libs_llvm-esp-16_0_4-20231113;
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
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20230928/riscv32-esp-elf-13.2.0_20230928-aarch64-linux-gnu.tar.xz";
    sha256 = "6ee4b30dff18bdea9ada79399c0c81ba82b6ed99a565746a7d5040c7e62566b3";
  };
  latest.bin.aarch64-linux.riscv32-esp-elf = bin.aarch64-linux.riscv32-esp-elf-13_2_0_20230928;
  bin.aarch64-linux.riscv32-esp-elf-13_2_0_20230928 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20230928/riscv32-esp-elf-13.2.0_20230928-aarch64-linux-gnu.tar.gz";
    sha256 = "b0ce269901981ed97feba130ff583a9377e5e70cef06c616ca2a6686287d8de0";
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
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20230928/riscv32-esp-elf-13.2.0_20230928-x86_64-linux-gnu.tar.gz";
    sha256 = "7d8c46828385212af66e18f9a1391be4d2f8d320075e7c9d9e11a3420d680dc0";
  };
  latest.bin.x86_64-linux.riscv32-esp-elf = bin.x86_64-linux.riscv32-esp-elf-13_2_0_20230928;
  bin.x86_64-linux.riscv32-esp-elf-13_2_0_20230928 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20230928/riscv32-esp-elf-13.2.0_20230928-x86_64-linux-gnu.tar.xz";
    sha256 = "782feefe354500c5f968e8c91959651be3bdbbd7ae8a17affcee2b1bffcaad89";
  };
  latest.bin.x86_64-linux.riscv32-esp-elf = bin.x86_64-linux.riscv32-esp-elf-13_2_0_20230928;
  bin.aarch64-darwin.rust-1_76_0_1 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.76.0.1/rust-1.76.0.1-aarch64-apple-darwin.tar.xz";
    sha256 = "8d3aa22ee641a06787ff8cf6974ec6a39fe1147a81d6641c93254a92d774068f";
  };
  latest.bin.aarch64-darwin.rust = bin.aarch64-darwin.rust-1_76_0_1;
  bin.aarch64-linux.rust-1_76_0_1 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.76.0.1/rust-1.76.0.1-aarch64-unknown-linux-gnu.tar.xz";
    sha256 = "e6647455471614f193ba16a5934b78cd5f69f93f0444c375f6d64fc6c648c3ab";
  };
  latest.bin.aarch64-linux.rust = bin.aarch64-linux.rust-1_76_0_1;
  bin.x86_64-darwin.rust-1_76_0_1 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.76.0.1/rust-1.76.0.1-x86_64-apple-darwin.tar.xz";
    sha256 = "3e69f0211ea5d5a7749e9d1f311b852181e6cea6ddaf1953ae843cec06e5b156";
  };
  latest.bin.x86_64-darwin.rust = bin.x86_64-darwin.rust-1_76_0_1;
  bin.x86_64-linux.rust-1_76_0_1 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.76.0.1/rust-1.76.0.1-x86_64-unknown-linux-gnu.tar.xz";
    sha256 = "f6708f898f0484c46b1b24a6f1e947b1d81a01cdef9c5b12405461441e43d355";
  };
  latest.bin.x86_64-linux.rust = bin.x86_64-linux.rust-1_76_0_1;
  src.rust-src-1_76_0_1 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.76.0.1/rust-src-1.76.0.1.tar.xz";
    sha256 = "2651a5498495c20e2e0a2fd9dd1c0a3bfb06825b183b80efa6e2c95e5626ea9b";
  };
  latest.src.rust-src = src.rust-src-1_76_0_1;
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
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20230928/xtensa-esp-elf-13.2.0_20230928-x86_64-apple-darwin.tar.xz";
    sha256 = "b9b7a6d1dc4ea065bf6763fa904729e1c808d6dfbf1dfabf12852e2929251ee9";
  };
  latest.bin.x86_64-darwin.xtensa-esp-elf = bin.x86_64-darwin.xtensa-esp-elf-13_2_0_20230928;
  bin.x86_64-darwin.xtensa-esp-elf-13_2_0_20230928 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20230928/xtensa-esp-elf-13.2.0_20230928-x86_64-apple-darwin.tar.gz";
    sha256 = "13716f49824d1429bf7cccbad45befb79adf1df7d2310c83e9457f4fddb12922";
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
