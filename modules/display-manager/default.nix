{
  pkgs,
  lib,
  config,
  user,
  wallpaper,
  ...
}:
with lib; let
  cfg = config.modules.display-manager;
in {
  options.modules.display-manager = {
    enable = mkEnableOption "display-manager";
    # pam_google_auth = mkOption {
    #   type = types.bool;
    #   default = false;
    #   description = "Enable pam_2fa with google authenticator";
    # };
  };
  config =
    mkIf cfg.enable
    {
      environment.systemPackages = with pkgs; [greetd.regreet];
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };
      environment.etc = {
        "greetd/regreet.toml".source = import ./regreet.nix {inherit pkgs wallpaper;};
        # We use a home manager generator to define the hyprland configuration.
        # We need to define the text field instead of a file.
        "greetd/hyprland.conf".text = import ./hyprland.nix {inherit pkgs lib wallpaper;};
      };
      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${lib.getExe config.programs.hyprland.package} --config /etc/greetd/hyprland.conf";
            # command = "${lib.getExe pkgs.cage} regreet";
            user = user;
          };
        };
      };
      boot.plymouth.enable = true;
    };
}
