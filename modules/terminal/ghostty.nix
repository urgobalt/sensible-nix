{
  config,
  sensibleLib,
  ...
}:
let
  c = config.lib.stylix.colors;
in
sensibleLib.sensibleConfig {
  condition = config.sensible.terminal.ghostty.enable;
  home.programs.ghostty = {
    enable = true;
    # TODO: fix package overrideability
    # package = config.sensible.terminal.ghostty.package;
    settings = {
      title = "Ghostty";
      class = "ghostty";
      confirm-close-surface = false;
      font-size = 10;
      font-family = "SauceCodePro NFP";
      font-style = "Medium";
      window-padding-x = 20;
      window-padding-y = 10;
      window-decoration = "none";
      background = "#${c.base00}";
      foreground = "#${c.base05}";
      cursor-color = "#${c.base06}";
      minimum-contrast = 1;
      background-opacity = 0.95;
      alpha-blending = "native";
      keybind = [ "ctrl+shift+d=new_window" ];
      palette = [
        "0=#${c.base00}"
        "1=#${c.base08}"
        "2=#${c.base0B}"
        "3=#${c.base0A}"
        "4=#${c.base0D}"
        "5=#${c.base0E}"
        "6=#${c.base0C}"
        "7=#${c.base05}"
        "8=#${c.base01}"
        "9=#${c.base08}"
        "10=#${c.base0B}"
        "11=#${c.base0A}"
        "12=#${c.base0D}"
        "13=#${c.base0E}"
        "14=#${c.base0C}"
        "15=#${c.base06}"
      ];
    };
  };
}
