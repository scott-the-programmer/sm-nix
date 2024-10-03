{ config, pkgs, username, ... }:

let
  tmuxConf = pkgs.writeText "tmux.conf" ''
    set -g @plugin 'tmux-plugins/tpm'
    set -g @plugin 'tmux-plugins/tmux-sensible'
    set -g @plugin 'dracula/tmux'
    # dracula options
    set -g @dracula-show-network false
    set -g @dracula-military-time true
    set -g @dracula-show-time true
    set -g @dracula-plugins "weather"
    set -g @dracula-show-fahrenheit false
    unbind C-b
    set-option -g prefix C-a
    set -g mouse on
    set-option -g history-limit 5000
    set -g base-index 1
    setw -g pane-base-index 1
    set -g renumber-windows on
    bind-key C-a send-prefix
    bind | split-window -h -c "#{pane_current_path}"
    bind * split-window -v -c "#{pane_current_path}" 
    bind -r t select-layout tiled 
    unbind '"'
    unbind %
    unbind r
    bind -r h select-pane -L
    bind -r l select-pane -R
    bind -r k select-pane -U
    bind -r j select-pane -D
    bind -r "<" swap-window -d -t -1
    bind -r ">" swap-window -d -t +1
    bind Space last-window
    bind r source-file ~/.tmux.conf
    unbind C-Left
    unbind C-Right
    unbind C-Up
    unbind C-Down
    bind -r Left resize-pane -L
    bind -r Right resize-pane -R 
    bind -r Up resize-pane -U
    bind -r Down resize-pane -D 
    set-option -g allow-rename off	
    setw -g mode-keys vi
    run '~/.tmux/plugins/tpm/tpm'
  '';
in
{
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile tmuxConf;
  };

  home.file.".tmux/plugins/tpm".source = pkgs.fetchFromGitHub {
    owner = "tmux-plugins";
    repo = "tpm";
    rev = "v3.0.0";
    sha256 = "qYBMDLIEkgiTFxjlF8AHn31HZ4nt/ZoeerzX70SSBaM=";
  };

  home.file.".tmux.conf".source = tmuxConf;

  home.file.".tmux/plugins/.keep".text = "";
}
