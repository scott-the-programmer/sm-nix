{ config, pkgs, username, ... }:

{
  home.username = "${username}";
  home.homeDirectory = "/Users/${username}";


  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  imports = [
    ../modules/fonts/config.nix
    ../modules/neovim/config.nix
    ../modules/alacritty/config.nix
    ../modules/zsh/config.nix
    ../modules/git/config.nix
    ../modules/tmux/config.nix
    ../modules/misc/config.nix
  ];
}
