{ config, pkgs, username ? null, ... }:

let
  currentUser = if username != null then username else builtins.getEnv "USER";
in
{
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 4;
  nixpkgs.hostPlatform = "x86_64-darwin";

  nixpkgs.config.allowUnfree = true;

  imports = [
     #./modules/brew/config.nix
     #./modules/dock/config.nix
  ];

  security.sudo.extraRules = [
    { users = [ currentUser ];
      options = [ "NOPASSWD" ];
    }
  ];

  security.sudo.wheelNeedsPassword = false;

  users.users.${currentUser} = {
    home = "/Users/${currentUser}";
    name = currentUser;
  };
}
