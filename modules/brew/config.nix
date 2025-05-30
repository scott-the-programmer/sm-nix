{ config, lib, pkgs, ... }:

{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    taps = [
      "FelixKratz/formulae"
    ];
    brews = [
      "sketchybar"
    ];
    casks = pkgs.callPackage ./casks.nix {};
  };
}
