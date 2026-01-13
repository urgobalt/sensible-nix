{
  pkgs,
  config,
  lib,
  sensibleLib,
  ...
}:
sensibleLib.sensibleConfig {
  condition = config.sensible.shell.zsh.enable;
  home.programs.zsh =
    {
      enable = true;
      package = config.system.sensible.shell.package;

      shellInit = import ./posix_init.nix {inherit config lib;};
    }
    // import ./general_shell_options.nix;
  # home.home.packages = import ./packages.nix pkgs;
}
