{
  config,
  sensibleLib,
  ...
}:
let
  c = config.lib.stylix.colors;
in
sensibleLib.sensibleConfig {
  condition = config.sensible.terminal.kitty.enable;
  assertions = [
    {
      assertion = config.stylix.enable or false;
      message = "kitty terminal requires stylix to be enabled for color theming";
    }
  ];
  home.programs.kitty = {
    enable = true;
    # TODO: fix package overrideability
    # package = config.sensible.terminal.kitty.package;
    settings = {
      confirm_os_window_close = 0;
      window_padding_width = 15;
      background_opacity = "0.95";
      font_size = 10;
      cursor = "#${c.base06}";
      foreground = "#${c.base05}";
      background = "#${c.base00}";
      selection_foreground = "#${c.base05}";
      selection_background = "#${c.base02}";
      color0 = "#${c.base00}";
      color8 = "#${c.base01}";
      color1 = "#${c.base08}";
      color9 = "#${c.base08}";
      color2 = "#${c.base0B}";
      color10 = "#${c.base0B}";
      color3 = "#${c.base0A}";
      color11 = "#${c.base0A}";
      color4 = "#${c.base0D}";
      color12 = "#${c.base0D}";
      color5 = "#${c.base0E}";
      color13 = "#${c.base0E}";
      color6 = "#${c.base0C}";
      color14 = "#${c.base0C}";
      color7 = "#${c.base05}";
      color15 = "#${c.base06}";
      active_tab_foreground = "#${c.base05}";
      active_tab_background = "#${c.base02}";
      inactive_tab_foreground = "#${c.base04}";
      inactive_tab_background = "#${c.base01}";
      active_border_color = "#${c.base03}";
      inactive_border_color = "#${c.base01}";
      inactive_text_alpha = "0.8";
    };
    keybindings = {
      "kitty_mod+t" = "no_op";
      "esc" = "no_op";
      "ctrl+plus" = "change_font_size all +2.0";
      "ctrl+minus" = "change_font_size all -2.0";
      "ctrl+0" = "change_font_size all 10";
      "ctrl+shift+d" = "launch --type=os-window --cwd=current --copy-env";
    };
  };
}
