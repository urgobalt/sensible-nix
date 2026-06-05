{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.social;
in {
  options.modules.social = {
    enable = mkEnableOption "social";
    useVesktop = mkOption {
      type = types.bool;
      default = true;
      description = "Use vesktop instead of standard Discord";
    };
  };

  config = mkIf cfg.enable {
    home.packages = 
      if cfg.useVesktop 
      then [ pkgs.unstable.vesktop ]
      else [ pkgs.discord ];
  };
}
