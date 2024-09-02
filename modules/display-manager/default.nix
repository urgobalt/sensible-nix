{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.display-manager;
  # regreet = import ./regreet.nix {inherit pkgs;};
in {
  options.modules.display-manager = {
    enable = mkEnableOption "display-manager";
    pam_google_auth = mkOption {
      type = types.bool;
      default = false;
      description = "Enable pam_2fa with google authenticator";
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = with pkgs; [
        (callPackage ./sddm-sugar-dark {})
      ];

      services.displayManager.sddm = {
        enable = true;
        enableHidpi = true;
        theme = "sugar-dark";
        wayland.enable = true;
      };

      boot.plymouth.enable = true;
    }
    (mkIf
      cfg.pam_google_auth
      {
        security.pam.services.sddm = {
          auth = [
            {
              # Standard UNIX authentication
              module = "pam_unix.so";
              arguments = "try_first_pass";
            }
            {
              # Google Authenticator module
              module = "pam_google_authenticator.so";
              arguments = "nullok";
            }
          ];
        };
      })
  ]);
}
