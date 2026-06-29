{
  pkgs,
  lib,
  config,
  sensibleLib,
  ...
}:
sensibleLib.sensibleConfig {
  condition = config.sensible.starship.enable;

  home.programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = false;
  };

  home.programs.fish.shellInit = ''
    ${lib.getExe pkgs.zoxide} init fish | source
  '';
}
