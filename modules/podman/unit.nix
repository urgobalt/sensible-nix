{
  config,
  pkgs,
  sensibleLib,
  ...
}:
sensibleLib.sensibleConfig {
  condition = config.sensible.podman.enable;
  system = {
    virtualisation.containers.enable = true;
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    environment.systemPackages = with pkgs; [
      dive
      podman-tui
      podman-compose
    ];
  };
}
