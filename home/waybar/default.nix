{
  pkgs,
  lib,
  config,
  colors,
  ...
}:
with lib; let
  cfg = config.modules.waybar;
  color = colors.rgba;
in {
  options.modules.waybar = {enable = mkEnableOption "waybar";};
  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
    };

    xdg.configFile."waybar/config.jsonc".text = import ./config.nix;
    xdg.configFile."waybar/style.css".text = import ./style.nix {inherit color;};

    xdg.configFile."waybar/scripts/battery.sh".source = ./battery.sh;

    home.packages = with pkgs; [
      acpi
      dust
      pwvucontrol
      pw-volume
    ];
  };
}
