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
  options.modules.display-manager = {enable = mkEnableOption "display-manager"; pam_google_auth = mkEnableOption "display-manager";};
  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [
    #   cage
    #   greetd.regreet
    # ];
    #
    # services.greetd = {
    #   enable = true;
    #   restart = true;
    #   settings = {
    #     default_session = {
    #       command = "cage -s -- regreet --config ${regreet}";
    #       user = "urgobalt";
    #     };
    #   };
    # };

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
    config=mkIf cfg.pam_google_auth {
      security.pam.services.sddm = {
        auth =  [
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
    };
  };
}
