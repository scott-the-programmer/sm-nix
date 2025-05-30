{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    fira-code
    fira-code-symbols
    hack-font
    jetbrains-mono
    victor-mono
    iosevka
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    nerd-fonts.victor-mono
    nerd-fonts.iosevka
  ];

  home.file.".config/fontconfig/fonts.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <dir>/Library/Fonts</dir>
      <dir>/System/Library/Fonts</dir>
      <dir>/usr/share/fonts</dir>
      <dir>/nix/store</dir>
      <dir>~/Library/Fonts</dir>
    </fontconfig>
  '';

  # home.activation = {
  #   rebuildFontCache = lib.hm.dag.entryAfter ["writeBoundary"] ''
  #     echo "Rebuilding font cache..."
  #     $DRY_RUN_CMD ${pkgs.fontconfig}/bin/fc-cache -f -v
  #   '';
  # };
}
