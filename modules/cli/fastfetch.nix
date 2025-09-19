{
  pkgs,
  config,
  lib,
  sensible_config,
  ...
}:
sensible_config {
  condition = config.sensible.sysinfo.name == "fastfetch";
  system.sensible.sysinfo.package = lib.mkDefault pkgs.fastfetch;
  home = {
    programs.fastfetch.enable = true;
    xdg.configFile."fastfetch/config.jsonc".source = ./fastfetch.jsonc;
  };
}
