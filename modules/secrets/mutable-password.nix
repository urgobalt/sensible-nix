{
  user,
  config,
  sensibleLib,
  ...
}: sensibleLib.sensibleConfig {
  condition = config.sensible.secrets.enable && config.sensible.secrets.passwordFile == null;
  assertions = [
    {
      assertion = config.sensible.secrets.password != null;
      message = "sensible.secrets.password must be set when passwordFile is null";
    }
  ];
  system = {
    users.mutableUsers = true;

    users.users.${user}.password = config.sensible.secrets.password;
  };
}
