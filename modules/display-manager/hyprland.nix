{
  pkgs,
  lib,
  monitors,
}:
lib.hm.generators.toHyprconf {
  attrs = {
    exec-once = ["${lib.getExe pkgs.regreet}; hyprctl dispatch exit"];
    monitor = monitors;
    misc = {
      disable_splash_rendering = true;
      disable_hyprland_logo = true;
    };
    animations = {
      enabled = 1;
      animation = [
        "windows,0"
      ];
    };
  };
}
