{
  config,
  sensibleLib,
  ...
}:
sensibleLib.sensibleConfig {
  condition = config.sensible.graphical_environment;
  imports = [
    ./ghostty.nix
    ./kitty.nix
    ./wezterm.nix
  ];
}
