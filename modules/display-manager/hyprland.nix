{
  pkgs,
  lib,
  wallpaper,
}:
lib.hm.generators.toHyprconf {
  attrs =
    {
      exec-once = with pkgs; ["${lib.getExe greetd.regreet}; hyprctl dispatch exit"];
      monitor = [",preferred, auto, 1"];
    }
    // (import ../../lib/hyprland_base.nix);
}
