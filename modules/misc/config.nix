{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gnupg
    lazygit
    delta
    jq
    nodejs
    arc-browser
    ripgrep
    fzf
    spotify
    htop
    nmap
    k9s
    neovim
    pulumi
    minikube
    pulumiPackages.pulumi-language-go
  ];

  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        theme = {
          lightTheme = false;
          activeBorderColor = ["green" "bold"];
          inactiveBorderColor = ["white"];
          optionsTextColor = ["blue"];
        };
      };
      git = {
        paging = {
          colorArg = "always";
          pager = "delta --dark --paging=never";
        };
      };
    };
  };

  programs.git = {
    enable = true;
    delta = {
      enable = true;
      options = {
        features = "side-by-side line-numbers decorations";
        syntax-theme = "Dracula";
        plus-style = "syntax #003800";
        minus-style = "syntax #3f0001";
      };
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      jqs = "jq -r 'keys'"; 
      jqp = "jq -r '.[]'"; 
    };
  };

  home.file.".jq".text = ''
    # Custom color scheme for jq
    def color_output:
      if type == "string" then "\u001b[32m" + . + "\u001b[0m"
      elif type == "number" then "\u001b[33m" + (.|tostring) + "\u001b[0m"
      elif type == "boolean" then "\u001b[1;33m" + (.|tostring) + "\u001b[0m"
      elif type == "null" then "\u001b[1;30mnull\u001b[0m"
      else .
      end;

    def colorize:
      (. | to_entries | map({key: .key, value: (.value | color_output)}) | from_entries);
  '';
}
