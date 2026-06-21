{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    niri = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable Niri, a scrollable-tiling Wayland compositor.";
      };
      keymaps = mkOption {
        type = with types; listOf str;
        default = [];
        description = "Extra KDL bind entries for Niri.";
      };
      extraConfig = mkOption {
        type = with types; listOf str;
        default = [];
        description = "Extra lines of KDL configuration for Niri.";
      };
    };
  }
