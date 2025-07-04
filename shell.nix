let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-25.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in
pkgs.mkShellNoCC {
  packages = [
    pkgs.curl
    pkgs.cacert
    pkgs.neovim
    pkgs.git
    pkgs.clang
    pkgs.nodejs
    pkgs.glibcLocales

    # for nvim

    # languages
    pkgs.go
    pkgs.cargo
    pkgs.python313Packages.python
    pkgs.python313Packages.pip
    pkgs.lua51Packages.lua
    pkgs.lua51Packages.luarocks
    pkgs.ruby
    pkgs.openjdk
    pkgs.julia
    pkgs.php
    pkgs.phpPackages.composer

    # tools
    pkgs.unzip # For Mason
    pkgs.ripgrep
    pkgs.tree-sitter
    pkgs.wget
    pkgs.xclip
  ];

  shellHook = ''
  export LOCALE_ARCHIVE=${pkgs.glibcLocales}/lib/locale/locale-archive
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
'';
}

