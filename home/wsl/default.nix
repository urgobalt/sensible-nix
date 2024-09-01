{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.wsl;
in {
  options.modules.wsl = {enable = mkEnableOption "wsl";};
  config = mkIf cfg.enable {
    systemd.user.sessionVariables.BROWSER = "wslview";

    home.packages = with pkgs; [
      wslu
      wsl-open
    ];
  };
}
