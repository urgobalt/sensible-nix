{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    pass = {
      enable = mkEnableOption "pass password manager";
    };
  }
