{ config, pkgs, username, ... }:
{
  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "git"
          "kubectl"
          "helm"
          "docker"
          "history"
          "sudo"
          "dirhistory"
          "colored-man-pages"
          "command-not-found"
          "z"
        ];
      };
      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.0";
            sha256 = "KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
          };
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "0.7.1";
            sha256 = "gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
          };
        }
        {
          name = "zsh-history-substring-search";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-history-substring-search";
            rev = "v1.0.2";
            sha256 = "0y8va5kc2ram38hbk2cibkk64ffrabfv1sh4xm7pjspsba9n5p1y";
          };
        }
      ];
      shellAliases = {
        ghub = "cd ~/Documents/github";
        ls = "ls -l";
        nconf = "nvim ~/.config/nvim";
        zconf = "nvim ~/.zshrc";
      }; 

      initExtra = ''
        export GOENV_ROOT="$HOME/.goenv"
        export PATH="$GOENV_ROOT/bin:$PATH"
        
        export PATH="$PATH:/Users/scott/Documents/github/flutter/bin"

        eval "$(goenv init -)"
      '';
    };
  };
}
