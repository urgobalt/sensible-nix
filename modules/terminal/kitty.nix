{
  lib,
  config,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    conditon = config.sensible.terminal.kitty.enable;
    home = {
      packages = [config.sensible.terminal.kitty.package];
      stylix.targets.kitty.enable = true;
      xdg.configFile."kitty/kitty.conf".text = import ./kitty_conf.nix;
    };
  }
