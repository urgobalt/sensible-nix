{
  pkgs,
  lib,
  config,
  user,
  ...
}:
with lib; let
  cfg = config.modules.declarative-password;
in {
  options.modules.declarative-password = {enable = mkEnableOption "declarative-password";};
  config = mkIf cfg.enable {
    users.mutableUsers = false;

    users.users.${user}.hashedPasswordFile = config.age.secrets.user-password.path;
  };
}
