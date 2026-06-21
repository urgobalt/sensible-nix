{
  config,
  pkgs,
  sensibleLib,
  ...
}:
sensibleLib.sensibleConfig {
  condition = config.sensible.eww.enable;
  home = {
    packages = with pkgs; [
      eww
      jq
      socat
      source-code-pro
    ];
    xdg.configFile."eww" = {
      source = ./bar;
      recursive = true;
    };
  };
}
