{
  lib,
config,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    conditon = config.sensible.terminal.wezterm.enable;
    home = {
      packages = [config.sensible.terminal.wezterm.package];
    };
  }
