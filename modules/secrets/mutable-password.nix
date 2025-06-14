{
  user,
  config,
  ...
}: {
  condition = config.sensible.secrets.password-file == null;
  system = {
    users.mutableUsers = true;

    users.users.${user}.password = "root";
  };
}
