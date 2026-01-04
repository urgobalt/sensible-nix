{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    terminal = {
      default = mkOption {
        type = types.enum ["kitty" "ghostty"];
        default = "kitty";
      };
      resolved = mkOption {
        type = types.package;
        readOnly = true;
      };
    };
  }
