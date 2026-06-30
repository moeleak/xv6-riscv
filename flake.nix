{
  description = "Development environment for xv6-riscv";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.gnumake
            pkgs.git
            pkgs.bc
            pkgs.clang-tools
            pkgs.bear
            pkgs.gdb
            pkgs.qemu
            pkgs.gcc
            pkgs.pkgsCross.riscv64.buildPackages.gcc
            pkgs.pkgsCross.riscv64.buildPackages.binutils
          ];

          shellHook = ''
            echo "=== XV6-RISCV Development Environment ==="
            echo "RISC-V Toolchain: $(riscv64-unknown-linux-gnu-gcc --version | head -n1)"
            echo "QEMU RISC-V: $(qemu-system-riscv64 --version | head -n1)"
            echo "Available commands:"
            echo "  make        - Build xv6"
            echo "  make qemu   - Run xv6 in QEMU"
            echo "=========================================="
          '';
        };

      }
    );
}
