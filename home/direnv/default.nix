{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.direnv;
in {
  options.modules.direnv = {enable = mkOption {
    type= types.bool;
    default=true;
  } ;};
  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
