{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    fuzzel = {
      enable = mkEnableOption "fuzzel application launcher";
    };
  }
