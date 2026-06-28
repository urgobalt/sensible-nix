{
  lib,
  config,
  sensibleLib,
  user,
  ...
}:
sensibleLib.sensibleConfig {
  condition = config.sensible.hyprland.enable == true;
  system = {
    sensible.graphical_environment = true;
    sensible.window_manager = config.home-manager.users.${user}.wayland.windowManager.hyprland.package;
  };
  home = {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.variables = ["--all"];
      xwayland.enable = true;
      settings = import ./hyprland-config.nix {
        inherit config lib sensibleLib;
      };
    };

    programs.hyprlock = {
      enable = true;
      settings = import ./hyprlock.nix {
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
