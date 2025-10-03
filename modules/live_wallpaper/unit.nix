{
  config,
  pkgs,
  sensible_config,
  ...
}:
sensible_config {
  imports = [./autostart.nix];
  condition = config.sensible.live_wallpaper.enable;
  home = {
    packages = [pkgs.mpvpaper];
  };
}
