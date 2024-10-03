{ config, pkgs, username, ... }:

{
  home.packages = with pkgs; [
    alacritty
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      window = {
        dimensions = {
          columns = 120;
          lines = 30;
        };
        padding = {
          x = 10;
          y = 10;
        };
      };
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };
        size = 12.0;
      };
      colors = {
        primary = {
          background = "0x1e2127";
          foreground = "0xabb2bf";
        };
      };
      cursor = {
        style = "Block";
        unfocused_hollow = true;
      };
    };
  }; 
}
