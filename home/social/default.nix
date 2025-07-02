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
  };
  config = mkIf cfg.enable {
    home.file.".config/discord/settings.json" = {
      # The `text` attribute takes a string, which we generate from a Nix attribute set.
      text = builtins.toJSON {
        SKIP_HOST_UPDATE = true;
        # You can add other Discord settings here as needed.
        # For example, to prevent it from starting on boot:
        OPEN_ON_STARTUP = false;
      };
    };
    home.packages = with pkgs; [
      unstable.discord
      unstable.discord-canary
      webcord
      whatsapp-for-linux
    ];
  };
}
