{ config, lib, ... }: {
  layerrule = [
    "blur, eww"
    "ignorezero, eww"

    "blur, swaync"
    "ignorezero, swaync"
    "animation slide right, swaync"
    "dimaround, swaync-control-center"
  ]
  ++ lib.optionals (config.sensible.launcher == "rofi") [
    "blur, rofi"
    "ignorezero, rofi"
    "noanim, rofi"
  ]
  ++ lib.optionals (config.sensible.launcher == "walker") [
    "blur, walker"
    "ignorezero, walker"
    "noanim, walker"
  ];

  # TODO: allow for setting a custom cursor using the rewrite
  input = {
    follow_mouse = 2;
    kb_layout = "se";
    sensitivity = 1;
    natural_scroll = false;
    scroll_method = "on_button_down";
    scroll_button = 274;
    special_fallthrough = true;
  };
  general = {
    gaps_in = 5;
    gaps_out = "0,20,20,20";
    border_size = 1;
    resize_on_border = false;

    snap = {
      enabled = true;
      window_gap = 20;
      monitor_gap = 5;
    };
  };
  master = {
    mfact = 0.5;
    inherit_fullscreen = 1;
    orientation = "center";
    slave_count_for_center_master = 2;
    new_status = "master";
  };
  decoration = {
    rounding = 5;
    shadow = {
      enabled = "false";
      range = 30;
    };
    inactive_opacity = 0.95;
    active_opacity = 0.95;
    blur = {
      size = 4;
      vibrancy = 1;
      passes = 3;
    };
  };
}
