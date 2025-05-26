{ config, pkgs, username ? null, ... }:

let
  currentUser = if username != null then username else builtins.getEnv "USER";
in
{
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 5;
  nixpkgs.hostPlatform = "x86_64-darwin";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  imports = [
     ./modules/brew/config.nix
     #./modules/dock/config.nix
  ];

  users.users.${currentUser} = {
    home = "/Users/${currentUser}";
    name = currentUser;
  };
}
