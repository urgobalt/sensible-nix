{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.steam;
in {
  options.modules.steam = {
    enable = mkEnableOption "steam";
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "The extra packages to add to steam";
    };
    gamemode = mkOption {
      type = types.bool;
      default = false;
      description = "enable gamemode";
    };
  };
  config = mkIf cfg.enable {
    programs.gamemode.enable = cfg.gamemode;
    programs.steam = {
      enable = true;
      extraCompatPackages = cfg.extraPackages;
    };
  };
}
