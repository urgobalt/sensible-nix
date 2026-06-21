{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    gtk = {
      enable = mkEnableOption "gtk dark theme and font configuration";
    };
  }
