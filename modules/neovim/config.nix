{ pkgs, lib, ... }:

let
  nvimConfig = builtins.fetchGit {
    url = "git@github.com:scott-the-programmer/nvim-config.git";
    ref = "master";
    rev = "96995e89b3068b6dd6f660dada49c280a75e9d55"; 
  };
in
{
  home.packages = with pkgs; [
    neovim
  ];

  home.file.".config/nvim" = {
    source = nvimConfig;
    recursive = true;
  };
}
