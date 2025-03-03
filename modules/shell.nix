{
  pkgs,
  lib,
  ...
}:
with lib; {
  options.modules.shell = mkOption {
    type = with types; package;
    default = pkgs.fish;
  };
  config = {
    programs.fish.enable = true;
    programs.zsh.enable = true;
  };
}
