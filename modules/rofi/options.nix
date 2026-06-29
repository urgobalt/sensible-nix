{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    rofi = {
      enable = mkEnableOption "rofi application launcher";
    };
  }
