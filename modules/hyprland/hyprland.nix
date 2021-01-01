{
  pkgs,
  lib,
  config,
  sensible_config,
  ...
}:
sensible_config {
  condition = config.sensible.hyprland.enable == true;
  system = {
    warnings = lib.optional (config.sensible.wallpaper.resolved == null) "Without a properly configured wallpaper in a graphical environment, some applications may have undefined behaviour since the wallpaper is used in multiple different places.";
  };
  home = {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.variables = ["--all"];
      xwayland.enable = true;
      plugins = with pkgs; [
        hyprkool
      ];
      settings = import ./hyprland-config.nix {
        inherit config lib;
      };
    };

    programs.hyprlock = {
      enable = true;
      settings = import ./hyprlock.nix {
        inherit lib config;
      };
    };

    services.hypridle.enable = true;
    services.hyprpaper = {
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
