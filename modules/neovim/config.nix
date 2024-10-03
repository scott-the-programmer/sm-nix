{ pkgs, lib, ... }: 
{
  home.packages = with pkgs; [
    neovim
  ];

  home.activation = {
    neovimSetup = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ ! -d $HOME/.config/nvim/.git ]; then
        $DRY_RUN_CMD mkdir -p $HOME/.config/nvim
        $DRY_RUN_CMD ${pkgs.git}/bin/git clone git@github.com/scott-the-programmer/nvim-config.git $HOME/.config/nvim
      else
        $DRY_RUN_CMD ${pkgs.git}/bin/git -C $HOME/.config/nvim pull
      fi
    '';
  };
}
