{
  description = "Nix-based C, C++ Development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/22.05";

    utils.url = "github:numtide/flake-utils";
    utils.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs: inputs.utils.lib.eachSystem [
    "x86_64-linux" "i686-linux" "aarch64-linux" "x86_64-darwin"
  ] (system: let pkgs = import nixpkgs {
                   inherit system;
                 };
              in {
                devShell = pkgs.mkShell rec {
                  name = "libnet-dev-shell";
                  packages = with pkgs; [
                    gnumake
                    pkg-config
                    automake
                    libtool
                    autoconf
                    indent
                    cmocka
                    # Compilers
                    gcc12
                    clang_14
                    # Other tools
                    clang-tools
                    bear
                    indent
                    shellcheck
                    cscope
                  ];
                };
              });
}
