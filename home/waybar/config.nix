builtins.toJSON {
  margin = "10 20 0 20";
  modules-left = ["hyprland/window" "custom/nix-packages" "custom/nix-store"];
  modules-center = ["clock"];
  modules-right = ["network" "bluetooth" "custom/volume" "custom/mem" "battery"];

  "hyprland/window" = {
    format = "{initialTitle}";
  };
  "custom/nix-packages" = {
    format = "{} 󱄅 ";
    intervall = 3600;
    exec = "ls -l /nix/store | rg .drv | wc -l";
    exec-if = "exit 0";
    signal = 8;
    tooltip = false;
  };
  "custom/nix-store" = {
    format = "{}  ";
    intervall = 3600;
    exec = "dust -d 0 /nix | cut -d ' ' -f 1";
    exec-if = "exit 0";
    signal = 9;
    tooltip = false;
  };
  clock = {
    timezone = "Europe/Stockholm";
    format = "{:%a %d %b %H:%M}";
    tooltip = false;
  };
  network = {
    interval = 10;
    format-ethernet = "󰈁";
    format-wifi = "{essid} {icon}";
    format-disconnected = "󰤮 ";
    format-linked = "󰤫 ";
    format-icons = ["󰤯 " "󰤟 " "󰤢 " "󰤥 " "󰤨 "];
    tooltip = false;
  };
  bluetooth = {
    format-on = "󰂯";
    format-off = "󰂲";
    format-connected = "󰂱";
  };
  "custom/volume" = {
    format = "{percentage}% {icon}";
    return-type = "json";
    signal = 11;
    interval = 1;
    format-icons = {
      mute = " ";
      default = " ";
    };
    exec = "pw-volume status";
    on-click = "pavucontrol";
    tooltip = false;
  };
  "custom/mem" = {
    format = "{}  ";
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
}
