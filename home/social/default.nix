{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.social;
in {
  options.modules.social = {
    enable = mkEnableOption "social";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      discord
      unstable.discord-canary
      webcord
      whatsapp-for-linux
    ];
  };
}
