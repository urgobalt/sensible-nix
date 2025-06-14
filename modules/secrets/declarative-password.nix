{
  user,
  config,
  ...
}: {
  condition = config.sensible.secrets.password-file != null;
  system = {
    users.mutableUsers = false;

    users.users.${user}.hashedPasswordFile = config.sensible.secrets.password-file;
  };
}
