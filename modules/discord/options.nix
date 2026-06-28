{
  lib,
  pkgs,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    discord = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable Discord with special workspace integration.";
      };
      package = mkOption {
        type = types.package;
        default = pkgs.discord;
        description = "Discord package to use.";
      };
    };
  }
