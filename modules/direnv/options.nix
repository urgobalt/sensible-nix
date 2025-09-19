{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    direnv = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable the direnv extension for your shell (https://direnv.net/).";
      };
      nix = mkOption {
        type = types.bool;
        default = true;
        description = "Enable the nix feature for direnv.";
      };
    };
  }
