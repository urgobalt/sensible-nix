{lib, ...}:
with lib; {
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
      type = types.enumOf ["master" "dwindle"];
      default = "master";
      description = "Hyprland window layout.";
    };
    debug = mkOption {
      type = types.bool;
      default = false;
      description = "Wether to enable to disable debug logs for hyprland. OBS: should not be kept enabled since the logs may leak important details.";
    };
  };
  live_wallpaper = {
    autostart = mkOption {
      type = types.bool;
      default = false;
      description = "Enable autostart for live wallpapers.";
    };
    default = mkOption {
      type = with types; nullOr path;
      default = null;
      description = "Default live wallpaper to be displayed. Supports many video formats.";
    };
  };
}
