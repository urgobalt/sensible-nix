{
  pkgs,
  config,
  lib,
  sensible_config,
  ...
}:
sensible_config {
  condition = config.sensible.sysinfo.name == "pfetch";
  system.sensible.sysinfo.package = lib.mkDefault pkgs.pfetch-rs;
  home.home.packages = [pkgs.pfetch-rs];
}
