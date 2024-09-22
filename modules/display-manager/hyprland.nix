{
  pkgs,
  lib,
  wallpaper,
}:
lib.hm.generators.toHyprconf {
  attrs = {
    exec-once = with pkgs; ["${lib.getExe greetd.regreet}; hyprctl dispatch exit"];
    monitor = [",preferred, auto, 1"];
    misc = {
      disable_splash_rendering = true;
      disable_hyprland_logo = true;
    };
    animations = {
      enabled = 1;
      animation = [
        "layers,1,3,default,fade"
      ];
    };
  };
}
