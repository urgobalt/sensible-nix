{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    steam = {
      enable = mkEnableOption "steam gaming platform";
      extraPackages = mkOption {
        type = with types; listOf package;
        default = [];
        description = "Extra compatibility packages for steam.";
      };
      gamemode = mkOption {
        type = types.bool;
        default = false;
        description = "Enable gamemode performance tweaks.";
      };
    };
  }
