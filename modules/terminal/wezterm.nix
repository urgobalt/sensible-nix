{
  config,
  sensibleLib,
  ...
}:
let
  c = config.lib.stylix.colors;
in
sensibleLib.sensibleConfig {
  condition = config.sensible.terminal.wezterm.enable;
  assertions = [
    {
      assertion = config.stylix.enable or false;
      message = "wezterm terminal requires stylix to be enabled for color theming";
    }
  ];
  home.programs.wezterm = {
    enable = true;
    # TODO: fix package overrideability
    # package = config.sensible.terminal.wezterm.package;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local cfg = wezterm.config_builder() or {}

      cfg.colors = {
        foreground = '#${c.base05}',
        background = '#${c.base00}',
        cursor_bg = '#${c.base06}',
        cursor_border = '#${c.base06}',
        selection_fg = '#${c.base05}',
        selection_bg = '#${c.base02}',
        ansi = {
          '#${c.base00}',
          '#${c.base08}',
          '#${c.base0B}',
          '#${c.base0A}',
          '#${c.base0D}',
          '#${c.base0E}',
          '#${c.base0C}',
          '#${c.base05}',
        },
        brights = {
          '#${c.base01}',
          '#${c.base08}',
          '#${c.base0B}',
          '#${c.base0A}',
          '#${c.base0D}',
          '#${c.base0E}',
          '#${c.base0C}',
          '#${c.base06}',
        },
      }

      cfg.font_size = 10.0
      cfg.window_padding = { left = 20, right = 20, top = 10, bottom = 10 }
      cfg.window_decorations = 'NONE'

      return cfg
    '';
  };
}
