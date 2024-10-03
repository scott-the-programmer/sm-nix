{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "scott-the-programmer";
    userEmail = "scott@murray.kiwi";
    
    extraConfig = {
      core = {
        editor = "nvim";
      };
      color = {
        ui = true;
      };
      pull = {
        rebase = true;
      };
      init = {
        defaultBranch = "main";
      };
    };

    lfs = {
      enable = true;
    };

    aliases = {
      co = "checkout";
      ci = "commit";
      st = "status";
      br = "branch";
      hist = "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
    };
  };

  home.packages = with pkgs; [
    git-lfs
  ];

  home.file.".gitignore_global".text = ''
    .DS_Store
    *.swp
    *~
  '';

  programs.git.ignores = [
    ".gitignore_global"
  ];
}
