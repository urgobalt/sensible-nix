{
  config,
  sensibleLib,
  ...
}:
sensibleLib.sensibleConfig {
  condition = config.sensible.steam.enable;
  system = {
    programs.gamemode.enable = config.sensible.steam.gamemode;
    programs.steam = {
      enable = true;
      extraCompatPackages = config.sensible.steam.extraPackages;
    };
  };
}
