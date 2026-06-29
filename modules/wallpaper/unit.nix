{
  config,
  sensibleLib,
  user,
  ...
}: let
  wallpaperPath = "sensible/wallpaper";
  homeDirectory = config.home-manager.users.${user}.home.homeDirectory;
in
  with sensibleLib;
    {
      condition = config.sensible.wallpaper.source != null;
      home.xdg.dataFile.${wallpaperPath}.source = config.sensible.wallpaper.source;
      system.sensible.wallpaper.resolved = "${homeDirectory}/.local/share/${wallpaperPath}";
    }
    |> makeGraphical config
    |> sensibleConfig
