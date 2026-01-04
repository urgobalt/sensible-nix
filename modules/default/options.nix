{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    monitors = mkOption {
      # TODO: create a custom type for representing a monitor and functions to translate them to the correct format
      type = with types; listOf str;
      default = [];
    };
    graphical_environment = mkOption {
      type = types.bool;
      default = false;
      internal = true;
    };
  }
