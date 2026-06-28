{
  config,
  pkgs,
  sensibleLib,
  lib,
  ...
}:
with sensibleLib;
  (makeGraphical config {
    condition = config.sensible.waybar.enable;
    system.sensible.hyprland.exec-once = ["waybar"];
    home = {
      programs.waybar = {
        enable = true;
      };
      xdg.configFile."waybar/config.jsonc".text = import ./config.nix { inherit config lib; };
      xdg.configFile."waybar/style.css".text = import ./style.nix {config = config;};
      xdg.configFile."waybar/scripts/battery.sh".source = ./battery.sh;
      xdg.configFile."waybar/scripts/volume.sh".source = ./volume.sh;
      home.packages = with pkgs; [
        acpi
        dust
        pwvucontrol
        pw-volume
      ];
    };
  })
  |> sensibleConfig
