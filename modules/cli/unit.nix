unit:
unit ({
  pkgs,
  config,
  ...
}: {
  condition = config.sensible.fish.enable;
  system.sensible.shell = pkgs.fish;
})
