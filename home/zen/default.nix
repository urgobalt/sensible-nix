{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.zen;
in {
  options.modules.zen = {enable = mkEnableOption "zen";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zen-browser
    ];
  };
}
