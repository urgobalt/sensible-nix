{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    secrets = {
      nixSecretOptions = mkOption {
        type = with types; nullOr path;
        default = null;
        description = "Secret file that will be imported at the end of nix.conf.";
      };
      passwordFile = mkOption {
        type = with types; nullOr path;
        default = null;
        description = "Secret file that holds the hashed user password. OBS: This option will make the users immutable.";
      };
      password = mkOption {
        type = types.str;
        default = "root";
        description = "The password configured through this field is public-readable and should only be used as an initial configuration. The field is not used if passwordFile is configured.";
      };
    };
  }
