{
  pkgs,
  lib,
  config,
  colors,
  ...
}:
with lib; let
  cfg = config.modules.dunst;
  c = colors.regular;
in {
  options.modules.dunst = {
    enable = mkOption {
      type = types.bool;
      default = config.modules.hyprland.enable;
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dunst
    ];

    services.dunst = {
      enable = true;
      settings = {
        global = {
          origin = "bottom-right";
          offset = "20x20";
          separator_height = 5;
          padding = 12;
          horizontal_padding = 12;
          text_icon_padding = 12;
          frame_width = 1;
          separator_color = "frame";
          idle_threshold = 120;
          font = "SourceCodePro Nerd Font 12";
          line_height = 0;
          format = "<b>%s</b>\n%b";
          alignment = "left";
          icon_position = "right";
          icon_corner_radius = 5;
          corner_radius = 5;

          frame_color = c.red;
          background = c.gray01;
          foreground = c.text;
          timeout = 10;
        };
      };
    };
  };
}
