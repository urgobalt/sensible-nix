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
  config = mkMerge [
    (mkIf (cfg.enable) {
      users.mutableUsers = false;

      users.users.${user}.hashedPasswordFile = path;
    })
    (mkIf (cfg.enable == false) {
      users.users.${user}.password = "root";
    })
  ];
}
