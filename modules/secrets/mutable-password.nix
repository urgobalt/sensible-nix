{
  user,
  config,
  ...
}: {
  condition = config.sensible.secrets.passwordFile == null;
  system = {
    users.mutableUsers = true;

    users.users.${user}.password = "root";
  };
}
