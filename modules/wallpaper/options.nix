{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    wallpaper = {
      source = mkOption {
        type = types.path;
        description = "Wallpaper used in graphical environments";
      };
      resolved = mkOption {
        type = types.path;
        internal = true;
      };
    };
  }
