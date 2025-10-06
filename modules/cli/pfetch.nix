{
  pkgs,
  config,
  sensible_config,
  ...
}:
sensible_config {
  condition = config.sensible.sysinfo.pfetch.enable;
  home.home.packages = [pkgs.pfetch-rs];
}
