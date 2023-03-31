{
  description = "A Nix-flake-based Toy Vulkan Engine development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs =
    { self
    , flake-utils
    , nixpkgs
    }:

    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShell = pkgs.mkShell {
        packages = with pkgs; [
          #
          gnumake
          clang
          pkg-config
          automake
          libtool
          autoconf
          indent
          cmocka

          # Compilers
          gcc12
          clang_14
        
          # Fonts
          #powerline-fonts
          #fira-code
          #fira-code-symbols

          # Other tools
          clang-tools
          bear
        ];

        shellHook = ''
          export PS1='\n\[\033[1;34m\][dev-shell][\u:\w]\$ \[\033[0m\]'
        '';
      };
    });
}
