{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    xdg = {
      enable = mkEnableOption "xdg user directories and mime defaults";
      defaultBrowser = mkOption {
        type = with types; nullOr str;
        default = null;
        description = "The default browser desktop file.";
      };
    };
  }
