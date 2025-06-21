{
  pkgs,
  lib,
  config,
  wallpaper,
  ...
}: {
  condition = config.sensible.hyprland.enable == true;
  system = {
    warnings = lib.optional (wallpaper == null) "Without a properly configured wallpaper in a graphical environment, some applications may have undefined behaviours since the wallpaper is used in multiple different places.";
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
        inherit lib config wallpaper;
      };
    };

    services.hypridle.enable = true;
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        preload = [wallpaper];
        wallpaper = [
          ",${wallpaper}"
        ];
      };
    };
  };
}
