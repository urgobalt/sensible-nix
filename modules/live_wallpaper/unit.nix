{
  config,
  pkgs,
  sensibleLib,
  ...
}:
sensibleLib.sensibleConfig {
  imports = [./autostart.nix];
  condition = config.sensible.live_wallpaper.enable;
  home = {
    packages = [pkgs.mpvpaper];
  };
}
