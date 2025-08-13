{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.pfetch;
in {
  options.modules.pfetch = {enable = mkEnableOption "pfetch";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [pfetch-rs];
  };
}
