{
  pkgs,
  config,
  lib,
  ...
}: {
  condition = config.sensible.sysinfo.name == "pfetch";
  system.sensible.sysinfo.package = lib.mkDefault pkgs.pfetch-rs;
  home.packages = [pkgs.pfetch-rs];
}
