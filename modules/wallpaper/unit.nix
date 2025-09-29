{
  config,
  sensible_config,
  user,
  ...
}: let
  wallpaperPath = "sensible/wallpaper";
  homeDirectory = config.home-manager.users.${user}.home.homeDirectory;
in
  sensible_config {
    condition = config.sensible.wallpaper != null;
    home.xdg.dataFile.${wallpaperPath}.source = config.sensible.wallpaper;
    system.sensible.wallpaper.resolved = "${homeDirectory}/.local/share/${wallpaperPath}";
  }
