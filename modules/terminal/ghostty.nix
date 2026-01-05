{
  lib,
  config,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    conditon = config.sensible.terminal.ghostty.enable;
    home = {
      packages = [config.sensible.terminal.ghostty.package];
      xdg.configFile."ghostty/config".text = import ./ghostty_config.nix {inherit color;};
    };
  }
