builtins.toJSON {
  margin = "20 20 0 20";
  modules-left = ["keyboard-state" "custom/nix-packages" "custom/nix-store"];
  modules-center = ["clock"];
  modules-right = ["custom/volume" "custom/mem" "battery" "tray"];
  keyboard-state = {
    capslock = true;
    format = "{name} {icon}";
    format-icons = {
      locked = "";
      unlocked = "";
    };
  };
  "custom/nix-packages" = {
    format = "{} 󱄅";
    intervall = 3600;
    exec = "ls -l /nix/store | rg .drv | wc -l";
    exec-if = "exit 0";
    signal = 8;
    tooltip = false;
  };
  "custom/nix-store" = {
    format = "{} ";
    intervall = 3600;
    exec = "dust -d 0 /nix | cut -d ' ' -f 1";
    exec-if = "exit 0";
    signal = 9;
    tooltip = false;
  };
  clock = {
    timezone = "Europe/Stockholm";
    tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    format = "{:%a, %d %b, %I:%M %p}";
  };
  "custom/volume" = {
    format = "{percentage}% {icon}";
    return-type = "json";
    signal = 10;
    interval = 5;
    format-icons = {
      mute = "";
      default = "";
    };
    exec = "pw-volume status";
  };
  "custom/mem" = {
    format = "{} ";
    interval = 3;
    exec = "free -h | awk '/Mem:/{printf $3}'";
    tooltip = false;
  };
  battery = {
    states = {
      warning = 30;
      critical = 15;
    };
    format = "{capacity}% {icon}";
    format-charging = "{capacity}% 󰂄";
    format-plugged = "{capacity}% 󰚥";
    format-alt = "{time} {icon}";
    format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
    on-update = "bash $HOME/.config/waybar/scripts/battery.sh";
  };
  tray = {
    icon-size = 16;
    spacing = 0;
  };
}
