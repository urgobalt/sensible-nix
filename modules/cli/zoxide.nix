{
  pkgs,
  lib,
  config,
  sensible_config,
  ...
}:
sensible_config {
  condition = config.sensible.starship.enable;

  home.programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = false; # Alias come before init breaking zoxide
  };
  home.programs.fish.shellInit = ''
    ${lib.getExe pkgs.zoxide} init fish | source
  '';
}
