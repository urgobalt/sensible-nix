{
  pkgs,
  config,
  lib,
  ...
}: {
  condition = config.sensible.shell.name == "zsh";
  system.sensible.shell.package = lib.mkDefault pkgs.zsh;
  home.programs.zsh =
    {
      enable = true;
      package = config.system.sensible.shell.package;

      shellInit = import ./posix_init.nix {inherit config lib;};
    }
    // import ./general_shell_options.nix;
  home.home.packages = import ./packages.nix pkgs;
}
