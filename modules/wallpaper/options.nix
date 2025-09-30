{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    wallpaper = {
      source = mkOption {
        type = with types; nullor path;
        default = null;
        description = "Wallpaper used in graphical environments";
      };
      resolved = mkOption {
        type = types.path;
        internal = true;
        readOnly = true;
      };
    };
  }
