{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.spacedrive;
in {
  options.modules.spacedrive = {enable = mkEnableOption "spacedrive";};
  config =
    mkIf cfg.enable {
      programs.spacedrive=enable;
    };
}
