{
  aarch64-darwin = {
    rust-esp = {
      url = "https://github.com/esp-rs/rust-build/releases/download/v1.69.0.0/rust-1.69.0.0-aarch64-apple-darwin.tar.xz";
      sha256 = "1vrl9d56gsb5gjzkjn903k58hd8y3658j5ivgr0jd3klgh0s4x3v";
    };

    rust-esp-src = {
      url = "https://github.com/esp-rs/rust-build/releases/download/v1.69.0.0/rust-src-1.69.0.0.tar.xz";
      sha256 = "1v30l5rn0zcra5x0xx802in67kpacywyvqjmn8v75h1walc3x3mg";
    };

    llvm-esp = {
      url = "https://github.com/espressif/llvm-project/releases/download/esp-15.0.0-20221201/libs_llvm-esp-15.0.0-20221201-macos-arm64.tar.xz";
      sha256 = "18ak1hpr4w89h89p9qgxp48p9s0m7clb4mn84vp96bg0sv0b01hr";
    };

    xtensa-esp32-elf = {
      url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/xtensa-esp32-elf-12.2.0_20230208-aarch64-apple-darwin.tar.xz";
      sha256 = "13nscn8h2jpzia0s2fyjmg871g2c895kwfriqmflgs8nnarcl2pm";
    };

    xtensa-esp32s2-elf = {
      url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/xtensa-esp32s2-elf-12.2.0_20230208-aarch64-apple-darwin.tar.xz";
      sha256 = "1w06amk2kmiw2nr4llcl6x28gkdh8a3sl962hwvkraa3bz79gjfj";
    };

    xtensa-esp32s3-elf = {
      url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/xtensa-esp32s3-elf-12.2.0_20230208-aarch64-apple-darwin.tar.xz";
      sha256 = "15bnxypbvy4lvf86qn2808si194i9sbgay1qibrgddn028z1m6mf";
    };

    riscv32-esp-elf = {
      url = "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/riscv32-esp-elf-12.2.0_20230208-aarch64-apple-darwin.tar.xz";
      sha256 = "1yd30c98q8n15da2bzx5v4nfxrpyykjwyyzw25lpcn5jmx8l22kc";
    };
  };
}
