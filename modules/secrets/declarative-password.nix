{
  user,
  config,
  ...
}: {
  condition = config.sensible.secrets.passwordFile != null;
  system = {
    users.mutableUsers = false;

    users.users.${user}.hashedPasswordFile = config.sensible.secrets.passwordFile;
  };
}
