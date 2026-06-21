{
  config,
  pkgs,
  sensibleLib,
  ...
}:
sensibleLib.sensibleConfig {
  condition = config.sensible.spacedrive.enable;
  home.home.packages = [pkgs.spacedrive];
}
