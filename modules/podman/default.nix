{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.podman;
in {
  options.modules.podman = {enable = mkEnableOption "podman";};
  config = mkIf cfg.enable {
    virtualisation.containers.enable = true;
    virtualisation.podman = {
      enable = true;
      # Use as a drop in replacement for docker and create an alias
      dockerCompat = true;
      # Required for containers to talk to each other
      defaultNetwork.settings.dns_enabled = true;
    };

    environment.systemPackages = with pkgs; [
      dive
      podman-tui
      podman-compose
    ];
  };
}
