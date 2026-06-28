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
      binds = mkOption {
        type = with types; listOf str;
        default = [];
        description = "Custom keymaps for hyprland. Same syntax as a normal hyprland configuration (comma separated list of inputs).";
      };
      launcherCommand = mkOption {
        type = with types; nullOr str;
        default = null;
        internal = true;
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
      windowrules = mkOption {
        type = with types; listOf str;
        default = [];
        description = "Rules for the different windows and workspaces";
      };
      debug = mkOption {
        type = types.bool;
        default = false;
        description = "Wether to enable to disable debug logs for hyprland. OBS: should not be kept enabled since the logs may leak important details.";
      };
    };
  }
