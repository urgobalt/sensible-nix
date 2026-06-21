{sensibleLib, config, ...}: {
  imports = [
    ./bash.nix
    ./fish.nix
    ./zsh.nix
  ];
  environment.systemPackages = [(sensibleLib.getDefaultPackage config.sensible.shell)];

  sensible.shell.fish.enable = config.sensible.shell.default == "fish";
  sensible.shell.zsh.enable  = config.sensible.shell.default == "zsh";
  sensible.shell.bash.enable = config.sensible.shell.default == "bash";
}
