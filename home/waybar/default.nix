{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.waybar;
in {
  options.modules.waybar = {enable = mkEnableOption "waybar";};
  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
    };

    xdg.configFile."waybar/config.jsonc".text = import ./config.nix;
    xdg.configFile."waybar/scripts/battery.sh".source = ./battery.sh;

    home.packages = with pkgs; [
      acpi
      dust
      pavucontrol
      pw-volume
    ];
  };
}
