{
  config,
  pkgs,
  sensibleLib,
  ...
}:
with sensibleLib;
  (makeGraphical config {
    condition = config.sensible.dunst.enable;
    home = {
      packages = [pkgs.dunst];
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
            timeout = 10;
          };
        };
      };
    };
  })
  |> sensibleConfig
