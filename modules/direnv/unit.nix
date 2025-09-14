{
  config,
  sensible_config,
  ...
}:
sensible_config {
  condition = config.sensible.direnv.enable;
  home.programs.direnv = {
    enable = true;
    nix-direnv.enable = config.sensible.direnv.nix;
  };
}
