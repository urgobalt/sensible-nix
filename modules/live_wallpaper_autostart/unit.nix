{
  config,
  pkgs,
  sensible_config,
  ...
}:
sensible_config {
  condition = config.sensible.live_wallpaper.enable;
  home = {
    packages = [pkgs.mpvpaper];
  };
  system = {
    imports = [./autostart.nix];
  };
}
