{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.spacedrive;
in {
  options.modules.spacedrive = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [spacedrive];
  };
}
