{unit, ...}:
unit ({
  pkgs,
  config,
  lib,
  ...
}: {
  condition = config.sensible.direnv.enable;
  home.programs.direnv = {
    enable = true;
    nix-direnv.enable = config.sensible.direnv.nix;
  };
})
