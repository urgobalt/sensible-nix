{
  lib,
  config,
  sensibleLib,
  user,
  ...
}:
sensibleLib.sensibleConfig {
  condition = config.sensible.niri.enable == true;
  system = {
    sensible.graphical_environment = true;
    sensible.window_manager = config.programs.niri.package;
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
