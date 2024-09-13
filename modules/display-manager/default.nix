{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.display-manager;
in {
  options.modules.display-manager = {
    enable = mkEnableOption "display-manager";
    pam_google_auth = mkOption {
      type = types.bool;
      default = false;
      description = "Enable pam_2fa with google authenticator";
    };

    theme = {
      package = mkOption {
        type = types.package;
        default = pkgs.callPackage ../../assets/Blur-Glassy-V.2 {
          inherit pkgs;
          name = cfg.theme.name;
        };
        description = "Path to the default.nix file for the theme";
      };
      name = mkOption {
        type = types.str;
        default = "Blur-Glassy-V.2";
        description = "The name of the theme";
      };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = [
        cfg.theme.package
      ];

      services.displayManager.sddm = {
        enable = true;
        enableHidpi = true;
        theme = cfg.theme.name;
        wayland.enable = true;
      };
      boot.plymouth.enable = true;
    }
    (mkIf
      cfg.pam_google_auth
      {
        environment.systemPackages = [
          pkgs.google-authenticator
          pkgs.qrencode
        ];

        security.pam.services.login = {
          googleAuthenticator.enable = true;
        };
      })
  ]);
}
