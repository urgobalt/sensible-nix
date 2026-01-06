{
  config,
  lib,
}: let
  colors = config.lib.stylix.colors;
in {
  exec-once = ["wlsunset -l -23 -L -46" "hyprkool daemon -m 2>&1 > ~/somelog.txt" "wl-paste --watch cliphist store"];

  plugin = {
    hyprkool = {
      overview = {
        hover_border_color = colors.base0A;
        focus_border_color = colors.base0A;
        workspace_gap_size = 5;
      };
    };
  };
}
