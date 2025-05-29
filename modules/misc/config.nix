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
    docker
    nmap
    k9s
    neovim
    pulumi
    pulumiPackages.pulumi-language-go
    atuin
    vscode
    discord
    slack
    entr
    gcc
    python3
    sshpass
    yarn
    argo
    dotnet-sdk_9
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
