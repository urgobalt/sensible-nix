{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    waybar = {
      enable = mkEnableOption "waybar status bar";
    };
  }
