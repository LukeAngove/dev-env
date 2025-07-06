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
    pkgs.github-cli

    # for nvim

    # languages
    pkgs.go
    pkgs.cargo
    pkgs.python313Packages.python
    pkgs.python313Packages.pip
    pkgs.uv
    pkgs.lua51Packages.lua
    pkgs.lua51Packages.luarocks
    pkgs.ruby
    pkgs.openjdk
    pkgs.julia
    pkgs.php
    pkgs.phpPackages.composer
    pkgs.nodejs

    # tools
    pkgs.unzip # For Mason
    pkgs.ripgrep
    pkgs.tree-sitter
    pkgs.wget
    pkgs.xclip
    pkgs.fzf
    pkgs.bat
    pkgs.fd
  ];

  shellHook = ''
  export LOCALE_ARCHIVE=${pkgs.glibcLocales}/lib/locale/locale-archive
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8

  export PATH=$HOME/.node_modules/@google/gemini-cli/bin:$PATH
  if ! command -v gemini &> /dev/null
  then
    npm install -g @google/gemini-cli
  fi
'';
}

