{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    walker = {
      enable = mkEnableOption "walker application launcher";
    };
  }
