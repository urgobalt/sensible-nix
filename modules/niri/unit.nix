{
  lib,
  config,
  sensibleLib,
  user,
  ...
}:
sensibleLib.sensibleConfig {
  condition = config.sensible.niri.enable == true;
  warnings = lib.optional (config.sensible.wallpaper.source == null) "Without a properly configured wallpaper in a graphical environment, some applications may have undefined behaviour since the wallpaper is used in multiple different places.";
  system = {
    sensible.graphical_environment = true;
    programs.niri.enable = true;
  };
  home = {
    xdg.configFile."niri/config.kdl".text = import ./niri-config.nix {
      inherit config lib sensibleLib;
    };

    programs.hyprlock = {
      enable = true;
      settings = import ../hyprland/hyprlock.nix {
        inherit lib config user;
      };
    };

    services.hypridle.enable = true;
    services.hyprpaper = lib.mkIf (config.sensible.wallpaper.source != null) {
      enable = true;
      settings = {
        ipc = "on";
        preload = [config.sensible.wallpaper.resolved];
        wallpaper = [
          ",${config.sensible.wallpaper.resolved}"
        ];
      };
    };
  };
}
