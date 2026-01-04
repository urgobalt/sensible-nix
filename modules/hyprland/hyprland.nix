{
  lib,
  config,
  sensible_config,
  user,
  ...
}:
sensible_config {
  condition = config.sensible.hyprland.enable == true;
  warnings = lib.optional (config.sensible.wallpaper.source == null) "Without a properly configured wallpaper in a graphical environment, some applications may have undefined behaviour since the wallpaper is used in multiple different places.";
  system.sensible.graphical_environment = true;
  home = {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.variables = ["--all"];
      xwayland.enable = true;
      settings = import ./hyprland-config.nix {
        inherit config lib;
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
