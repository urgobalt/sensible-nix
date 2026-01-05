{
  sensible_config,
  config,
  pkgs,
  ...
}:
sensible_config {
  condition = config.sensible.graphical_environment;
  system = {
    sensible.terminal.resolved = pkgs.kitty;
  };
}
{
  imports = [
    ./ghostty.nix
    ./kitty.nix
    ./wezterm.nix
  ];
}
