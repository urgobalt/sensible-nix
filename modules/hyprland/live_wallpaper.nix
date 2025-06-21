{
  config,
  pkgs,
  lib,
  ...
}: let
  default_wallpaper = let
    ret = config.sensible.live_wallpaper.default;
  in
    lib.trivial.throwIf (ret == null) "Autostart live wallpaper does not support the wallpaper being null." ret;
in {
  condition = config.sensible.live_wallpaper.autostart;
  home = {
    packages = [pkgs.mpvpaper];
  };
  system.sensible.hyprland.exec-once = ["mpvpaper -f -o \"loop no-audio\" ${lib.strings.concatStringsSep "," config.sensible.monitors} $(${default_wallpaper} sed \"s|~|$HOME|\")"];
}
