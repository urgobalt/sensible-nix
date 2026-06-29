{
  config,
  sensibleLib,
  ...
}:
sensibleLib.sensibleConfig {
  condition = config.sensible.ssh.enable;
  home = {
    services.ssh-agent.enable = true;
    file.".ssh/config".text =
      # ponytail: ssh key files need to be configured manually
      "";
  };
}
