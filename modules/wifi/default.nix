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

    useNetworkd = mkOption {
      type = types.bool;
      default = false;
      description = "Switch the wireless backend from standard scripted networking to systemd-networkd with native link monitoring.";
    };

    matchInterfaces = mkOption {
      type = types.str;
      default = "wlp* wlan*";
      description = "The glob pattern systemd-networkd uses to match and manage wireless interfaces.";
    };

    networks = mkOption {
      type = types.attrs;
      default = {};
      description = "Declarative Wi-Fi network blocks matching NixOS networking.wireless.networks schema.";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      age.secrets.wifi-env = {
        mode = "0440";
        group = "wpa_supplicant";
      };
      networking.networkmanager.enable = false;
      networking.wireless = {
        enable = true;
        userControlled = true;
        secretsFile = config.age.secrets.wifi-env.path;
        networks = cfg.networks;
      };
    }

    (mkIf (!cfg.useNetworkd) {
      })

    (mkIf cfg.useNetworkd {
      networking.useNetworkd = true;

      systemd.network = {
        enable = true;
        networks."25-wireless" = {
          matchConfig.Name = cfg.matchInterfaces;
          networkConfig = {
            DHCP = "yes";
            IgnoreCarrierLoss = "3s";
          };
          dhcpV4Config = {
            RouteMetric = 300;
          };
          ipv6AcceptRAConfig = {
            RouteMetric = 300;
          };
        };
      };

      systemd.services.wpa_supplicant = {
        wants = ["agenix.service"];
        after = ["agenix.service"];

        serviceConfig = {
          Restart = "on-failure";
          RestartSec = "2s";
        };
      };
    })
  ]);
}
