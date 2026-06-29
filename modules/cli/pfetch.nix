{
  pkgs,
  config,
  sensibleLib,
  ...
}:
sensibleLib.sensibleConfig {
  condition = config.sensible.sysinfo.pfetch.enable;
  home.home.packages = [pkgs.pfetch-rs];
}
