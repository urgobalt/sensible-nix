{
  config,
  sensible_config,
  ...
}:
sensible_config {
  condition = config.sensible.sysinfo.fastfetch.enable;
  home = {
    programs.fastfetch.enable = true;
    xdg.configFile."fastfetch/config.jsonc".text = import ./fastfetch_jsonc.nix;
  };
}
