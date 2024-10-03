{ config, pkgs, lib, ... }:

let
  raycastSettings = {
    "global" = {
      "theme" = "auto";
      "soundEffects" = false;
      "menuBarIcon" = "raycast-icon-black";
      "showGettingStarted" = false;
      "analyticsEnabled" = false;
      "darkThemeAppearance" = "dark";
      "lightThemeAppearance" = "light";
    };
    "quicklinks" = {
      "openInBrowser" = true;
    };
    "extensions" = {
      "enabledStores" = [
        "Raycast Store"
      ];
    };
    "search" = {
      "defaultActionOnEnter" = "show-details";
      "enableRecentSearches" = true;
    };
  };

  raycastSettingsFile = pkgs.writeText "raycast-settings.json" (builtins.toJSON raycastSettings);
in
{
  home.packages = [ pkgs.raycast ];

  home.activation.raycastSettings = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ~/Library/Preferences/com.raycast.macos
    cp ${raycastSettingsFile} ~/Library/Preferences/com.raycast.macos/preferences.json
  '';

  home.file.".config/raycast/config.json".text = builtins.toJSON {
    hotkey = "cmd+space";
    showInMenuBar = true;
    enableAutomaticUpdate = true;
  };
}
