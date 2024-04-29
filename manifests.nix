rec {
  bin.aarch64-darwin.riscv32-esp-elf-13_2_0_20240305 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240305/riscv32-esp-elf-13.2.0_20240305-aarch64-apple-darwin.tar.xz";
    sha256 = "1e48833974a8e9ad2a0ac287ad244b825392d623edaf269bd66f4d8a215a0ef8";
  };
  latest.bin.aarch64-darwin.riscv32-esp-elf = bin.aarch64-darwin.riscv32-esp-elf-13_2_0_20240305;
  bin.aarch64-darwin.riscv32-esp-elf-13_2_0_20240305 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240305/riscv32-esp-elf-13.2.0_20240305-aarch64-apple-darwin.tar.gz";
    sha256 = "49538604b5f697246a824b7f3cd2ecf60cb5e8d656217e941346a1ce7d1a5779";
  };
  latest.bin.aarch64-darwin.riscv32-esp-elf = bin.aarch64-darwin.riscv32-esp-elf-13_2_0_20240305;
  bin.aarch64-linux.riscv32-esp-elf-13_2_0_20240305 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240305/riscv32-esp-elf-13.2.0_20240305-aarch64-linux-gnu.tar.xz";
    sha256 = "806ccd08333a96ae73507625a1762f7ac7a8c82f193602cafb835c4d7f5678ab";
  };
  latest.bin.aarch64-linux.riscv32-esp-elf = bin.aarch64-linux.riscv32-esp-elf-13_2_0_20240305;
  bin.aarch64-linux.riscv32-esp-elf-13_2_0_20240305 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240305/riscv32-esp-elf-13.2.0_20240305-aarch64-linux-gnu.tar.gz";
    sha256 = "8f6fc05cea159e5a1ff78cacbd90d2eb52e89aba0a0cd2debf3b42ded59dfdf9";
  };
  latest.bin.aarch64-linux.riscv32-esp-elf = bin.aarch64-linux.riscv32-esp-elf-13_2_0_20240305;
  bin.x86_64-darwin.riscv32-esp-elf-13_2_0_20240305 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240305/riscv32-esp-elf-13.2.0_20240305-x86_64-apple-darwin.tar.gz";
    sha256 = "4989b7a6cc53a042fce4d95f3d880962607d4304ec2a5deb931e3413d9a374cd";
  };
  latest.bin.x86_64-darwin.riscv32-esp-elf = bin.x86_64-darwin.riscv32-esp-elf-13_2_0_20240305;
  bin.x86_64-darwin.riscv32-esp-elf-13_2_0_20240305 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240305/riscv32-esp-elf-13.2.0_20240305-x86_64-apple-darwin.tar.xz";
    sha256 = "dfb4a2f46c66a9246a25e3c34b19a91c7a3f33a44721cd61ec01d442d5344193";
  };
  latest.bin.x86_64-darwin.riscv32-esp-elf = bin.x86_64-darwin.riscv32-esp-elf-13_2_0_20240305;
  bin.x86_64-linux.riscv32-esp-elf-13_2_0_20240305 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240305/riscv32-esp-elf-13.2.0_20240305-x86_64-linux-gnu.tar.gz";
    sha256 = "9ae3234ad41662a194cd0a4e97867286e24962f27ab0cffc031e3e10174a331b";
  };
  latest.bin.x86_64-linux.riscv32-esp-elf = bin.x86_64-linux.riscv32-esp-elf-13_2_0_20240305;
  bin.x86_64-linux.riscv32-esp-elf-13_2_0_20240305 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240305/riscv32-esp-elf-13.2.0_20240305-x86_64-linux-gnu.tar.xz";
    sha256 = "2bd71171ddb801e59c85ecbea3b89d6f707627d6c11e501cae43ca7c0db73eda";
  };
  latest.bin.x86_64-linux.riscv32-esp-elf = bin.x86_64-linux.riscv32-esp-elf-13_2_0_20240305;
  bin.aarch64-darwin.rust-1_77_0_0 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.77.0.0/rust-1.77.0.0-aarch64-apple-darwin.tar.xz";
    sha256 = "b2edb594b5828ac18331195b4c5e3beaa94264ef27de282be5d74ce118c59c8c";
  };
  latest.bin.aarch64-darwin.rust = bin.aarch64-darwin.rust-1_77_0_0;
  bin.aarch64-linux.rust-1_77_0_0 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.77.0.0/rust-1.77.0.0-aarch64-unknown-linux-gnu.tar.xz";
    sha256 = "4eb31941f83a6941c18bb958d9d7f96ae27c94da164e6f1ac2682ccae37c8cd9";
  };
  latest.bin.aarch64-linux.rust = bin.aarch64-linux.rust-1_77_0_0;
  bin.x86_64-darwin.rust-1_77_0_0 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.77.0.0/rust-1.77.0.0-x86_64-apple-darwin.tar.xz";
    sha256 = "83ca4d75e092cb103f58baf595d955ee0c60dabaaf26db395b31f270b1a43a45";
  };
  latest.bin.x86_64-darwin.rust = bin.x86_64-darwin.rust-1_77_0_0;
  bin.x86_64-linux.rust-1_77_0_0 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.77.0.0/rust-1.77.0.0-x86_64-unknown-linux-gnu.tar.xz";
    sha256 = "0da50faaf7c5b9f80bdfee06b5ce9ff8013408e48c995a72185c98fe8ac5524a";
  };
  latest.bin.x86_64-linux.rust = bin.x86_64-linux.rust-1_77_0_0;
  src.rust-src-1_77_0_0 = {
    url = "https://github.com/esp-rs/rust-build/releases/download/v1.77.0.0/rust-src-1.77.0.0.tar.xz";
    sha256 = "21289237703e24e022c6f3e4905ce936eee4b8fd44ccdf7105279a8433485d25";
  };
  latest.src.rust-src = src.rust-src-1_77_0_0;
  bin.aarch64-darwin.xtensa-esp-elf-13_2_0_20240305 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240305/xtensa-esp-elf-13.2.0_20240305-aarch64-apple-darwin.tar.gz";
    sha256 = "2ab383b13f9c18690affd398f4fef58e5b07b5bb23bbc91a90127d8bd321bf18";
  };
  latest.bin.aarch64-darwin.xtensa-esp-elf = bin.aarch64-darwin.xtensa-esp-elf-13_2_0_20240305;
  bin.aarch64-darwin.xtensa-esp-elf-13_2_0_20240305 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240305/xtensa-esp-elf-13.2.0_20240305-aarch64-apple-darwin.tar.xz";
    sha256 = "e2bf7886bb39ad6558e1f46160fae887705f903ea8b77cd28bbf77093d3ca286";
  };
  latest.bin.aarch64-darwin.xtensa-esp-elf = bin.aarch64-darwin.xtensa-esp-elf-13_2_0_20240305;
  bin.aarch64-linux.xtensa-esp-elf-13_2_0_20240305 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240305/xtensa-esp-elf-13.2.0_20240305-aarch64-linux-gnu.tar.xz";
    sha256 = "06bc30be9d824fa8da507dff228085563baa7f6251e42a14deae0ca0e93ec2eb";
  };
  latest.bin.aarch64-linux.xtensa-esp-elf = bin.aarch64-linux.xtensa-esp-elf-13_2_0_20240305;
  bin.aarch64-linux.xtensa-esp-elf-13_2_0_20240305 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240305/xtensa-esp-elf-13.2.0_20240305-aarch64-linux-gnu.tar.gz";
    sha256 = "c814897f9c8ea1c2665710c280eda55fc3f3664f2e5b82eb01ebab1807cf5803";
  };
  latest.bin.aarch64-linux.xtensa-esp-elf = bin.aarch64-linux.xtensa-esp-elf-13_2_0_20240305;
  bin.x86_64-darwin.xtensa-esp-elf-13_2_0_20240305 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240305/xtensa-esp-elf-13.2.0_20240305-x86_64-apple-darwin.tar.xz";
    sha256 = "5bf2b5ececdf92169e5a084d2485b8d0d60480ce130a3035dc407f01e4e7820d";
  };
  latest.bin.x86_64-darwin.xtensa-esp-elf = bin.x86_64-darwin.xtensa-esp-elf-13_2_0_20240305;
  bin.x86_64-darwin.xtensa-esp-elf-13_2_0_20240305 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240305/xtensa-esp-elf-13.2.0_20240305-x86_64-apple-darwin.tar.gz";
    sha256 = "19c7e97703512c64c0f9df78df8e6766b0120dc8a1fe244ea526c382ae1fed55";
  };
  latest.bin.x86_64-darwin.xtensa-esp-elf = bin.x86_64-darwin.xtensa-esp-elf-13_2_0_20240305;
  bin.x86_64-linux.xtensa-esp-elf-13_2_0_20240305 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240305/xtensa-esp-elf-13.2.0_20240305-x86_64-linux-gnu.tar.xz";
    sha256 = "4e43e56cd533a39c6b0ccc8b30320b19ce66b0b17e646b53fa84c9bf956b2c83";
  };
  latest.bin.x86_64-linux.xtensa-esp-elf = bin.x86_64-linux.xtensa-esp-elf-13_2_0_20240305;
  bin.x86_64-linux.xtensa-esp-elf-13_2_0_20240305 = {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240305/xtensa-esp-elf-13.2.0_20240305-x86_64-linux-gnu.tar.gz";
    sha256 = "84005aaab483b54515252e2ccf326f160470951747a634dda27282d63ef9e84d";
  };
  latest.bin.x86_64-linux.xtensa-esp-elf = bin.x86_64-linux.xtensa-esp-elf-13_2_0_20240305;
}
