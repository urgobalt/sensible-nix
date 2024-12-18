{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.wifi;
in {
  options.modules.wifi = {
    enable = mkEnableOption "wifi";
    networks = mkOption {
      type = types.attrs;
      default = {};
      description = "wifi networks";
    };
  };
  config = mkIf cfg.enable {
    networking.wireless.enable = true;
    networking.networkmanager.enable = false;

    networking.wireless.userControlled.enable = true;
    networking.wireless.secretsFile = config.age.secrets.wifi-env.path;
    networking.wireless.networks = cfg.networks;
  };
}
