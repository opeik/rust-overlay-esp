rec {
  bin.aarch64-darwin.libs-clang-esp-18_1_2_20240829 = {
    url = "https://github.com/espressif/llvm-project/releases/download/esp-18.1.2_20240829/libs-clang-esp-18.1.2_20240829-aarch64-apple-darwin.tar.xz";
    sha256 = "dbbf205c0c8ee60659b684c0822279b1f23e7fd7e7482e7158b36e40da598596";
  };
  latest.bin.aarch64-darwin.libs-clang-esp = bin.aarch64-darwin.libs-clang-esp-18_1_2_20240829;
  bin.aarch64-linux.libs-clang-esp-18_1_2_20240829 = {
    url = "https://github.com/espressif/llvm-project/releases/download/esp-18.1.2_20240829/libs-clang-esp-18.1.2_20240829-aarch64-linux-gnu.tar.xz";
    sha256 = "5b253ac79fc1bc8c2013f787e85b6b305d2589848b5ba959cc94a1a43a7077c9";
  };
  latest.bin.aarch64-linux.libs-clang-esp = bin.aarch64-linux.libs-clang-esp-18_1_2_20240829;
  bin.x86_64-darwin.libs-clang-esp-18_1_2_20240829 = {
    url = "https://github.com/espressif/llvm-project/releases/download/esp-18.1.2_20240829/libs-clang-esp-18.1.2_20240829-x86_64-apple-darwin.tar.xz";
    sha256 = "48e1c770639bc9c2ca45d4fedd1ff18c7fac1e613c05904d2855bc74520fd05e";
  };
  latest.bin.x86_64-darwin.libs-clang-esp = bin.x86_64-darwin.libs-clang-esp-18_1_2_20240829;
  bin.x86_64-linux.libs-clang-esp-18_1_2_20240829 = {
    url = "https://github.com/espressif/llvm-project/releases/download/esp-18.1.2_20240829/libs-clang-esp-18.1.2_20240829-x86_64-linux-gnu.tar.xz";
    sha256 = "765976eb738a0f942df976bd0c009bee53402e2aa20439bbbb06a45688951b18";
  };
  latest.bin.x86_64-linux.libs-clang-esp = bin.x86_64-linux.libs-clang-esp-18_1_2_20240829;
  bin.aarch64-darwin.riscv32-esp-elf-14_2_0_20240906 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20240906/riscv32-esp-elf-14.2.0_20240906-aarch64-apple-darwin.tar.xz";
    sha256 = "cce902f01cb261905f5898d30887b81704a2b9d0f5de0d3806be7bfad55a505d";
  };
  latest.bin.aarch64-darwin.riscv32-esp-elf = bin.aarch64-darwin.riscv32-esp-elf-14_2_0_20240906;
  bin.aarch64-linux.riscv32-esp-elf-14_2_0_20240906 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20240906/riscv32-esp-elf-14.2.0_20240906-aarch64-linux-gnu.tar.xz";
    sha256 = "dfb8e029c09a5a5dba16fa8d9e5a5008a80b9c843467d863102ec5359f9b77d2";
  };
  latest.bin.aarch64-linux.riscv32-esp-elf = bin.aarch64-linux.riscv32-esp-elf-14_2_0_20240906;
  bin.x86_64-darwin.riscv32-esp-elf-14_2_0_20240906 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20240906/riscv32-esp-elf-14.2.0_20240906-x86_64-apple-darwin.tar.xz";
    sha256 = "40bc1e783e1119aceb59b3f7a1cec633d91f7a89a39ec04d6a3408b31eff17d4";
  };
  latest.bin.x86_64-darwin.riscv32-esp-elf = bin.x86_64-darwin.riscv32-esp-elf-14_2_0_20240906;
  bin.x86_64-linux.riscv32-esp-elf-14_2_0_20240906 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20240906/riscv32-esp-elf-14.2.0_20240906-x86_64-linux-gnu.tar.xz";
    sha256 = "c20b1ee91611622364146be5709decb03451af3f39fd1bce0636fc49d6391e3d";
  };
  latest.bin.x86_64-linux.riscv32-esp-elf = bin.x86_64-linux.riscv32-esp-elf-14_2_0_20240906;
  bin.aarch64-darwin.rust-1_81_0_0 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.81.0.0/rust-1.81.0.0-aarch64-apple-darwin.tar.xz";
    sha256 = "1200963f30166e050cfb3c5aa9878b180f52bf26f33004cb324f6baef6597390";
  };
  latest.bin.aarch64-darwin.rust = bin.aarch64-darwin.rust-1_81_0_0;
  bin.aarch64-linux.rust-1_81_0_0 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.81.0.0/rust-1.81.0.0-aarch64-unknown-linux-gnu.tar.xz";
    sha256 = "489ece3cf5e063eeedd3a340293ba5d220e279ee69c401d8c794e6c3ef08009c";
  };
  latest.bin.aarch64-linux.rust = bin.aarch64-linux.rust-1_81_0_0;
  bin.x86_64-darwin.rust-1_81_0_0 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.81.0.0/rust-1.81.0.0-x86_64-apple-darwin.tar.xz";
    sha256 = "0a56c3bb5b04aa1beaf2406cc741a664fa13609231f134a14078857775174726";
  };
  latest.bin.x86_64-darwin.rust = bin.x86_64-darwin.rust-1_81_0_0;
  bin.x86_64-linux.rust-1_81_0_0 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.81.0.0/rust-1.81.0.0-x86_64-unknown-linux-gnu.tar.xz";
    sha256 = "444dc2fee358bec2f8a41313c12f8876a803d626467f3a73d3fe794c0dff34de";
  };
  latest.bin.x86_64-linux.rust = bin.x86_64-linux.rust-1_81_0_0;
  src.rust-src-1_81_0_0 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.81.0.0/rust-src-1.81.0.0.tar.xz";
    sha256 = "ee90b44fa2ddba3088f0fda1102a94786ed38996c9e67af96e0dd11a17f0ee70";
  };
  latest.src.rust-src = src.rust-src-1_81_0_0;
  bin.aarch64-darwin.xtensa-esp-elf-14_2_0_20240906 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20240906/xtensa-esp-elf-14.2.0_20240906-aarch64-apple-darwin.tar.xz";
    sha256 = "0450fc0c91688960a41b3a213e5b6ed387bc81af53d7428f074fb0a560b53070";
  };
  latest.bin.aarch64-darwin.xtensa-esp-elf = bin.aarch64-darwin.xtensa-esp-elf-14_2_0_20240906;
  bin.aarch64-linux.xtensa-esp-elf-14_2_0_20240906 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20240906/xtensa-esp-elf-14.2.0_20240906-aarch64-linux-gnu.tar.xz";
    sha256 = "13d593a288a94c7e29b5ac4cf872608dfb4c61a0378265f355134fc5e69d38cc";
  };
  latest.bin.aarch64-linux.xtensa-esp-elf = bin.aarch64-linux.xtensa-esp-elf-14_2_0_20240906;
  bin.x86_64-darwin.xtensa-esp-elf-14_2_0_20240906 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20240906/xtensa-esp-elf-14.2.0_20240906-x86_64-apple-darwin.tar.xz";
    sha256 = "499dc8492046c878b5173fcefafb90fad06e4294613e0b934ca57767e552e285";
  };
  latest.bin.x86_64-darwin.xtensa-esp-elf = bin.x86_64-darwin.xtensa-esp-elf-14_2_0_20240906;
  bin.x86_64-linux.xtensa-esp-elf-14_2_0_20240906 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20240906/xtensa-esp-elf-14.2.0_20240906-x86_64-linux-gnu.tar.xz";
    sha256 = "e7c01501d5e32d317c3fadb9d97d1988b586c6e051c6d75a3bbcef3357ce1a51";
  };
  latest.bin.x86_64-linux.xtensa-esp-elf = bin.x86_64-linux.xtensa-esp-elf-14_2_0_20240906;
}
