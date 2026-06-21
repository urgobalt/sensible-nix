{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    swaync = {
      enable = mkEnableOption "swaync notification center";
    };
  }
