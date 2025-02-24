{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.swaync;
in {
  options.modules.swaync = {enable = mkEnableOption "swaync";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [swaynotificationcenter];
  };
}
