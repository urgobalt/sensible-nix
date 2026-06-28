{
  config,
  lib,
  sensibleLib,
  ...
}:
sensibleLib.sensibleConfig {
  condition = config.sensible.shell.bash.enable;
  home.programs.bash =
    {
      enable = true;
      package = config.system.sensible.shell.bash.package;

      bashrcExtra = import ./posix_init.nix {inherit config lib;};
    }
    // import ./general_shell_options.nix;
  # home.home.packages = import ./packages.nix pkgs;
}
