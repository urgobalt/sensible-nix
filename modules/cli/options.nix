{
  lib,
  pkgs,
  ...
}:
with lib; {
  options = {
    sensible = {
      shell = mkOption {
        type = types.package;
        default = pkgs.bash;
        description = "The default shell that is used by the user.";
      };
      fish = {
        enable = mkOption {
          type = types.bool;
          default = false;
          description = "Enable the friendly interactive shell; Enable fish";
        };
      };
    };
  };
}
