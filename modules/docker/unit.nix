{
  config,
  sensibleLib,
  user,
  ...
}:
sensibleLib.sensibleConfig {
  condition = config.sensible.docker.enable;
  system = {
    users.users.${user}.extraGroups = ["docker"];
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
