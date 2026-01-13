{
  config,
  pkgs,
  sensibleLib,
  ...
}:
sensibleLib.sensibleConfig {
  condition = config.sensible.graphical_environment;
  system = {
    sensible.terminal.package = pkgs.kitty;
  };
  imports = [
    ./ghostty.nix
    ./kitty.nix
    ./wezterm.nix
  ];
}
