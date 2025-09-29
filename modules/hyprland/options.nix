{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    hyprland = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable hyprland window manager.";
      };
      keymaps = mkOption {
        type = with types; listOf str;
        default = [];
        description = "Custom keymaps for hyprland. Same syntax as a normal hyprland configuration (comma separated list of inputs).";
      };
      exec-once = mkOption {
        type = with types; listOf str;
        default = [];
        description = "List of commands that should be executed at Hyprland launch.";
      };
      layout = mkOption {
        type = types.enum ["master" "dwindle"];
        default = "master";
        description = "Hyprland window layout.";
      };
      debug = mkOption {
        type = types.bool;
        default = false;
        description = "Wether to enable to disable debug logs for hyprland. OBS: should not be kept enabled since the logs may leak important details.";
      };
    };
    wallpaper = {
      source = mkOption {
        type = types.path;
        description = "Wallpaper used in graphical environments";
      };
      resolved = mkOption {
        type = types.path;
        internal = true;
      };
    };
  }
