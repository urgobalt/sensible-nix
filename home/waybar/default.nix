{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.waybar;
in {
  options.modules.waybar = {enable = mkEnableOption "waybar";};
  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          # Size/position
          layer = "bottom";
          position = "top";
          height = 30;

          # Modules
          left-modules = ["hyprland/workspaces"];
          center-modules = ["hyprland/window"];
          modules-right = [
            "tray"
            "custom/spotify"
            "custom/storage"
            "backlight"
            "pulseaudio"
            "network"
            "idle_inhabitor"
            "battery"
            "clock"
          ];
          "hyprland/workspaces" = {
            disable_scroll = true;
          };
          "hyprland/window" = {
            separate_outputs = true;
          };
        };
      };
    };
  };
}
