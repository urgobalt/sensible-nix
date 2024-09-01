{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.steam;
in {
  options.modules.steam = {enable = mkEnableOption "steam";};
  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
    };
  };
}
