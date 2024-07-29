rec {
  bin.aarch64-darwin.riscv32-esp-elf-13_2_0_20240530 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240530/riscv32-esp-elf-13.2.0_20240530-aarch64-apple-darwin.tar.xz";
    sha256 = "230628fcf464ca8856c82c55514e40a8919e97fbc5e66b7165ca42c9653d2302";
  };
  latest.bin.aarch64-darwin.riscv32-esp-elf = bin.aarch64-darwin.riscv32-esp-elf-13_2_0_20240530;
  bin.aarch64-darwin.riscv32-esp-elf-13_2_0_20240530 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240530/riscv32-esp-elf-13.2.0_20240530-aarch64-apple-darwin.tar.gz";
    sha256 = "7082dd2e2123dea5609a24092d19ac6612ae7e219df1d298de6b2f64cb4af0df";
  };
  latest.bin.aarch64-darwin.riscv32-esp-elf = bin.aarch64-darwin.riscv32-esp-elf-13_2_0_20240530;
  bin.aarch64-linux.riscv32-esp-elf-13_2_0_20240530 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240530/riscv32-esp-elf-13.2.0_20240530-aarch64-linux-gnu.tar.xz";
    sha256 = "276351b883a53e81b695d858be74114a8b627bbe4fc9c69ef46a7127ab143680";
  };
  latest.bin.aarch64-linux.riscv32-esp-elf = bin.aarch64-linux.riscv32-esp-elf-13_2_0_20240530;
  bin.aarch64-linux.riscv32-esp-elf-13_2_0_20240530 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240530/riscv32-esp-elf-13.2.0_20240530-aarch64-linux-gnu.tar.gz";
    sha256 = "a178a895b807ed2e87d5d62153c36a6aae048581f527c0eb152f0a02b8de9571";
  };
  latest.bin.aarch64-linux.riscv32-esp-elf = bin.aarch64-linux.riscv32-esp-elf-13_2_0_20240530;
  bin.x86_64-darwin.riscv32-esp-elf-13_2_0_20240530 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240530/riscv32-esp-elf-13.2.0_20240530-x86_64-apple-darwin.tar.xz";
    sha256 = "cfbf5deaba05bf217701c8ceab7396bb0c2ca95ab58e134d4b2e175b86c2fd6c";
  };
  latest.bin.x86_64-darwin.riscv32-esp-elf = bin.x86_64-darwin.riscv32-esp-elf-13_2_0_20240530;
  bin.x86_64-darwin.riscv32-esp-elf-13_2_0_20240530 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240530/riscv32-esp-elf-13.2.0_20240530-x86_64-apple-darwin.tar.gz";
    sha256 = "a193b4f025d0d836b0a9d9cbe760af1c53e53af66fc332fe98952bc4c456dd9a";
  };
  latest.bin.x86_64-darwin.riscv32-esp-elf = bin.x86_64-darwin.riscv32-esp-elf-13_2_0_20240530;
  bin.x86_64-linux.riscv32-esp-elf-13_2_0_20240530 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240530/riscv32-esp-elf-13.2.0_20240530-x86_64-linux-gnu.tar.gz";
    sha256 = "e7fbfffbb19dcd3764a9848a141bf44e19ad0b48e0bd1515912345c26fe52fba";
  };
  latest.bin.x86_64-linux.riscv32-esp-elf = bin.x86_64-linux.riscv32-esp-elf-13_2_0_20240530;
  bin.x86_64-linux.riscv32-esp-elf-13_2_0_20240530 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240530/riscv32-esp-elf-13.2.0_20240530-x86_64-linux-gnu.tar.xz";
    sha256 = "f69a491d2f42f63e119f9077da995f7743ea8e1bf6944166a42a312cf60728a8";
  };
  latest.bin.x86_64-linux.riscv32-esp-elf = bin.x86_64-linux.riscv32-esp-elf-13_2_0_20240530;
  bin.aarch64-darwin.rust-1_80_0_0 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.80.0.0/rust-1.80.0.0-aarch64-apple-darwin.tar.xz";
    sha256 = "e058af380e01b46a92d2e3abaeb8b82960e04c305fe96c6420574c539111de49";
  };
  latest.bin.aarch64-darwin.rust = bin.aarch64-darwin.rust-1_80_0_0;
  bin.aarch64-linux.rust-1_80_0_0 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.80.0.0/rust-1.80.0.0-aarch64-unknown-linux-gnu.tar.xz";
    sha256 = "873c855d8cdee53381f52fd36fbed077873a8cd23d4d5b484014771c1fff1257";
  };
  latest.bin.aarch64-linux.rust = bin.aarch64-linux.rust-1_80_0_0;
  bin.x86_64-darwin.rust-1_80_0_0 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.80.0.0/rust-1.80.0.0-x86_64-apple-darwin.tar.xz";
    sha256 = "61143ebaa68c756b4d9b450ddc7e500877ef5b0ce8effb545c1111174a44f049";
  };
  latest.bin.x86_64-darwin.rust = bin.x86_64-darwin.rust-1_80_0_0;
  bin.x86_64-linux.rust-1_80_0_0 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.80.0.0/rust-1.80.0.0-x86_64-unknown-linux-gnu.tar.xz";
    sha256 = "d3cc878d69936459051324f76298f1fdc55ce1a4492cd9084ccdaf8d53cf57d5";
  };
  latest.bin.x86_64-linux.rust = bin.x86_64-linux.rust-1_80_0_0;
  src.rust-src-1_80_0_0 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.80.0.0/rust-src-1.80.0.0.tar.xz";
    sha256 = "ece206ac1a6039cf1d2464e0769bb501f57d27e549e0de01c395f9975a6c868f";
  };
  latest.src.rust-src = src.rust-src-1_80_0_0;
  bin.aarch64-darwin.xtensa-esp-elf-13_2_0_20240530 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240530/xtensa-esp-elf-13.2.0_20240530-aarch64-apple-darwin.tar.gz";
    sha256 = "6f03fdf0cc14a7f3900ee59977f62e8626d8b7c208506e52f1fd883ac223427a";
  };
  latest.bin.aarch64-darwin.xtensa-esp-elf = bin.aarch64-darwin.xtensa-esp-elf-13_2_0_20240530;
  bin.aarch64-darwin.xtensa-esp-elf-13_2_0_20240530 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240530/xtensa-esp-elf-13.2.0_20240530-aarch64-apple-darwin.tar.xz";
    sha256 = "d967e49a64f823e18fbae273efb1b094ac55e2207aa21fd3947c9d59f999f47e";
  };
  latest.bin.aarch64-darwin.xtensa-esp-elf = bin.aarch64-darwin.xtensa-esp-elf-13_2_0_20240530;
  bin.aarch64-linux.xtensa-esp-elf-13_2_0_20240530 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240530/xtensa-esp-elf-13.2.0_20240530-aarch64-linux-gnu.tar.xz";
    sha256 = "cfe55b92b4baeaa4309a948ba65e2adfc2d17a542c64856e36650869b419574a";
  };
  latest.bin.aarch64-linux.xtensa-esp-elf = bin.aarch64-linux.xtensa-esp-elf-13_2_0_20240530;
  bin.aarch64-linux.xtensa-esp-elf-13_2_0_20240530 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240530/xtensa-esp-elf-13.2.0_20240530-aarch64-linux-gnu.tar.gz";
    sha256 = "7c9e3c1adc733d042ed87b92daa1d6396e1b441c1755f1fa14cb88855719ba88";
  };
  latest.bin.aarch64-linux.xtensa-esp-elf = bin.aarch64-linux.xtensa-esp-elf-13_2_0_20240530;
  bin.x86_64-darwin.xtensa-esp-elf-13_2_0_20240530 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240530/xtensa-esp-elf-13.2.0_20240530-x86_64-apple-darwin.tar.xz";
    sha256 = "39ee7df749f4ceb93624d73627688d5b86269a7429022f986f2940499936aacd";
  };
  latest.bin.x86_64-darwin.xtensa-esp-elf = bin.x86_64-darwin.xtensa-esp-elf-13_2_0_20240530;
  bin.x86_64-darwin.xtensa-esp-elf-13_2_0_20240530 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240530/xtensa-esp-elf-13.2.0_20240530-x86_64-apple-darwin.tar.gz";
    sha256 = "948cf57b6eecc898b5f70e06ad08ba88c08b627be570ec631dfcd72f6295194a";
  };
  latest.bin.x86_64-darwin.xtensa-esp-elf = bin.x86_64-darwin.xtensa-esp-elf-13_2_0_20240530;
  bin.x86_64-linux.xtensa-esp-elf-13_2_0_20240530 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240530/xtensa-esp-elf-13.2.0_20240530-x86_64-linux-gnu.tar.xz";
    sha256 = "fcef03d87eac44c0dbee2bbee98443ed2fcf82720dcd8ebfe00640807b0f07c2";
  };
  latest.bin.x86_64-linux.xtensa-esp-elf = bin.x86_64-linux.xtensa-esp-elf-13_2_0_20240530;
  bin.x86_64-linux.xtensa-esp-elf-13_2_0_20240530 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240530/xtensa-esp-elf-13.2.0_20240530-x86_64-linux-gnu.tar.gz";
    sha256 = "bce77e8480701d5a90545369d1b5848f6048eb39c0022d2446d1e33a8e127490";
  };
  latest.bin.x86_64-linux.xtensa-esp-elf = bin.x86_64-linux.xtensa-esp-elf-13_2_0_20240530;
}
