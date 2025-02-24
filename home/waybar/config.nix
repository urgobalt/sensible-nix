builtins.toJSON {
  margin = "10 20 0 20";
  modules-left = ["custom/nix-packages" "custom/nix-store" "disk" "memory" "cpu"];
  modules-center = ["clock"];
  modules-right = ["hyprland/window" "network" "bluetooth" "custom/volume" "battery"];

  "custom/nix-packages" = {
    format = "{} 󱄅 ";
    interval = 60;
    exec = "sqlite3 'file:/nix/var/nix/db/db.sqlite?readonly=true&immutable=true' 'SELECT COUNT(DISTINCT drv) FROM DerivationOutputs'";
    signal = 8;
    tooltip = false;
  };
  "custom/nix-store" = {
    format = "{}  ";
    interval = 60;
    exec = "sqlite3 'file:/nix/var/nix/db/db.sqlite?readonly=true&immutable=true' 'SELECT SUM(narSize) FROM ValidPaths' | numfmt --to iec";
    signal = 9;
    tooltip = false;
  };
  disk = {
    format = "{used} / {total}  ";
    tooltip-format = "{used} used out of {total} ({percentage})";
  };
  "memory" = {
    format = "{used:0.1f}GiB / {total:0.1f}GiB  ";
    interval = 3;
    tooltip = true;
    tooltip-format = "{used:0.1f}GiB used out of {total:0.1f}GiB ({percentage}%)";
  };
  cpu = {
    format = "{usage}%  ";
    interval = 3;
  };
  clock = {
    timezone = "Europe/Stockholm";
    format = "{:%a %d %b %H:%M}";
    tooltip = false;
  };
  "hyprland/window" = {
    format = "{initialTitle}";
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
