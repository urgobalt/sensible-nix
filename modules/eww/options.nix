{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    eww = {
      enable = mkEnableOption "eww widget system";
    };
  }
