{
  pkgs,
  lib,
  config,
  user,
  ...
}:
with lib; let
  cfg = config.modules.declarative-password;
  path = config.age.secrets.user-password.path;
  path_exist = pathExists path;
in {
  options.modules.declarative-password = {enable = mkEnableOption "declarative-password";};
  config = mkMerge [
    (mkIf (cfg.enable && path_exist) {
      users.mutableUsers = false;

      users.users.${user}.hashedPasswordFile = path;
    })
    (mkIf (cfg.enable == false || path_exist == false) {
      users.users.${user}.initialPassword = "root";
    })
  ];
}
