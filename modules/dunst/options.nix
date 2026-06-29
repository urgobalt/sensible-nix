{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    dunst = {
      enable = mkEnableOption "dunst notification daemon";
    };
  }
