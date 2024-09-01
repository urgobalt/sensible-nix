{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.plasma;
in {
  options.modules.plasma = {enable = mkEnableOption "plasma";};
  config =
    mkIf cfg.enable {
      services.desktopManager.plasma6.enable = true;
    };
}
