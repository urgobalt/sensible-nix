{
  config,
  pkgs,
  lib,
  sensible_config,
  ...
}:
sensible_config {
  condition = config.sensible.live_wallpaper.autostart;
  home = {
    packages = [pkgs.mpvpaper];
  };
  system = {
    assertions = [
      {
        assertion = config.sensible.live_wallpaper.default != null;
        message = "A default wallpaper is required for autostart to be enabled";
      }
    ];
    sensible.hyprland.exec-once = ["mpvpaper -f -o \"loop no-audio\" ${lib.strings.concatStringsSep "," config.sensible.monitors} $(${config.sensible.live_wallpaper.default} sed \"s|~|$HOME|\")"];
  };
}
