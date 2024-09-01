{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.wifi;
in {
  options.modules.wifi = {enable = mkEnableOption "wifi";};
  config = mkIf cfg.enable {
    networking.wireless.enable = true;
    networking.networkmanager.enable = false;

    networking.wireless.userControlled.enable = true;
    networking.wireless.environmentFile = config.age.secrets.wifi-env.path;
    networking.wireless.networks = {
      "Spökhuset" = {
        psk = "@PSK_SPOKHUSET@";
        priority = 4;
      };
      "Nygren" = {
        psk = "@PSK_NYGREN@";
        priority = 5;
      };
      "Cinderblock" = {
        psk = "@PSK_CINDERBLOCK@";
        priority = 10;
      };
      "eduroam" = {
        auth = ''
          key_mgmt=WPA-EAP
          eap=PEAP
          identity="@I_EDUROAM@"
          password="@PSK_EDUROAM@"
          phase2="auth=MSCHAPV2"
        '';
        priority = 20;
      };
      "urgobalt" = {
        psk = "@PSK_URGOBALT@";
        priority = 99;
      };
    };
  };
}
