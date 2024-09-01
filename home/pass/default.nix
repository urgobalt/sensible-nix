{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.pass;
in {
  options.modules.pass = {enable = mkEnableOption "pass";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      pass-wayland
      gpg-tui
    ];

    programs.gpg = {
      enable = true;
    };

    services.gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
      enableSshSupport = false;
    };
  };
}
