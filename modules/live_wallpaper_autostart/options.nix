{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    live_wallpaper = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable live wallpapers on your system.";
      };
      autostart = mkOption {
        type = types.bool;
        default = false;
        description = "Enable autostart for live wallpapers.";
      };
      default = mkOption {
        type = with types; nullOr path;
        default = null;
        description = "Default live wallpaper to be displayed. Supports many video formats.";
      };
    };
  }
