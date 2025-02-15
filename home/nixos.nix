{ config, pkgs, username, ... }:

{
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  imports = [
    ../modules/fonts/config.nix
    ../modules/alacritty/config.nix
    ../modules/zsh/config.nix
    ../modules/git/config.nix
    ../modules/tmux/config.nix
    ../modules/misc/config.nix
  ];
}
