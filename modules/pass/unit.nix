{
  config,
  pkgs,
  sensibleLib,
  ...
}:
sensibleLib.sensibleConfig {
  condition = config.sensible.pass.enable;
  home = {
    home.packages = with pkgs; [
      pass-wayland
      gpg-tui
    ];
    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-curses;
      enableSshSupport = false;
    };
  };
}
