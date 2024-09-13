{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.zen-browser;
in {
  options.modules.zen-browser = {enable = mkEnableOption "zen-browser";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zen-browser
    ];
  };
}
