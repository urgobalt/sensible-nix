{config}:
let
  c = config.lib.stylix.colors;
in
  # tmux config with stylix colors
  ''
    # Color correction
    set -g default-terminal "tmux-256color"
    set-option -ga terminal-overrides ",xterm-256color*:Tc"

    # Leader key
    unbind C-b
    set-option -g prefix C-Space
    bind-key C-Space send-prefix

    # Escape key delay
    set -sg escape-time 0

    # Reload config file
    bind r source-file ~/.tmux.conf

    # Splitting panes
    bind v split-window -h
    bind s split-window -v
    unbind '"'
    unbind %

    # Vim integration
    is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?\\.(view|n?vim?x?)(-wrapped)?(diff)?$'"

    # Pane Movement
    bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
    bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
    bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
    bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'

    bind-key -T copy-mode-vi 'C-h' select-pane -L
    bind-key -T copy-mode-vi 'C-j' select-pane -D
    bind-key -T copy-mode-vi 'C-k' select-pane -U
    bind-key -T copy-mode-vi 'C-l' select-pane -R

    # Resize
    bind -n 'C-M-h' if-shell "$is_vim" 'send-keys C-M-h' 'resize-pane -L 5'
    bind -n 'C-M-j' if-shell "$is_vim" 'send-keys C-M-j' 'resize-pane -D 2'
    bind -n 'C-M-k' if-shell "$is_vim" 'send-keys C-M-k' 'resize-pane -U 2'
    bind -n 'C-M-l' if-shell "$is_vim" 'send-keys C-M-l' 'resize-pane -R 5'

    bind-key -T copy-mode-vi C-M-h resize-pane -L 5
    bind-key -T copy-mode-vi C-M-j resize-pane -D 2
    bind-key -T copy-mode-vi C-M-k resize-pane -U 2
    bind-key -T copy-mode-vi C-M-l resize-pane -R 5

    # Disable mouse
    set -g mouse off

    # Design
    set -g visual-activity off
    set -g visual-bell off
    set -g visual-silence off
    setw -g monitor-activity off
    set -g bell-action none

    setw -g clock-mode-colour ${c.base08}
    setw -g mode-style 'fg=${c.base08} bg=${c.base01} bold'

    set -g pane-border-style 'fg=${c.base05}'
    set -g pane-active-border-style 'fg=${c.base05}'

    set -g status-position bottom
    set -g status-justify left
    set -g status-style 'fg=${c.base05} bg=${c.base00}'
    set -g status-left '#[fg=${c.base0C}]▊'
    set -g status-right '%Y-%m-%d %H:%M #[fg=${c.base0C}]▊'
    set -g status-right-length 50
    set -g status-left-length 10

    setw -g window-status-current-style 'fg=${c.base0A}'
    setw -g window-status-current-format ' #I #W #F '

    setw -g window-status-style 'fg=${c.base05}'
    setw -g window-status-format ' #I #W #F '

    setw -g window-status-bell-style 'fg=${c.base0B} bg=${c.base08} bold'

    set -g message-style 'fg=${c.base0B} bg=${c.base00} bold'
  ''
