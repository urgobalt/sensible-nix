{
  config,
  pkgs,
  sensibleLib,
  ...
}:
sensibleLib.sensibleConfig {
  condition = config.sensible.tmux.enable;
  home.home = {
    packages = [pkgs.tmux];
    file.".tmux.conf".text = import ./tmux_conf.nix {inherit config;};
  };
}
