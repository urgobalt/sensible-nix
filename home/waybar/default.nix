{
  pkgs,
  lib,
  config,
  colors,
  ...
}:
with lib; let
  cfg = config.modules.waybar;
  c = colors.rgba;
in {
  options.modules.waybar = {enable = mkEnableOption "waybar";};
  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
    };

    xdg.configFile."waybar/config.jsonc".text = import ./config.nix;
    xdg.configFile."waybar/style.css".text = ''
      * {
        border: none;
        border-radius: 0;
        font-family: SauceCodePro Nerd Font;
        font-size: 14px;
      }

      window#waybar {
        background: transparent;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      #window {
        padding: 5px 16px;
        margin-right: 20px;
        border-radius: 5px;
        transition: none;
        color: ${c.text};
        background: ${c.background};
      }

      window#waybar.empty #window {
        background: transparent;
        padding: 0px;
        margin: 0px;
      }

      #custom-nix-packages {
        padding: 5px 8px 5px 16px;
        border-radius: 5px 0px 0px 5px;
        transition: none;
        color: ${c.text};
        background: ${c.background};
      }

      #custom-nix-store {
        padding: 5px 16px 5px 8px;
        border-radius: 0px 5px 5px 0px;
        transition: none;
        color: ${c.text};
        background: ${c.background};
      }

      #disk {
        padding: 5px 16px;
        margin-left: 20px;
        border-radius: 5px;
        transition: none;
        color: ${c.text};
        background: ${c.background};
      }

      #clock {
        padding: 5px 16px;
        border-radius: 5px;
        transition: none;
        color: ${c.text};
        background: ${c.background};
      }

      #network {
        padding: 5px 16px;
        margin-right: 20px;
        border-radius: 5px;
        transition: none;
        color: ${c.text};
        background: ${c.background};
      }

      #bluetooth {
        padding: 5px 16px;
        margin-right: 20px;
        border-radius: 5px;
        transition: none;
        color: ${c.text};
        background: ${c.background};
      }

      #custom-volume {
        padding: 5px 16px;
        margin-right: 20px;
        border-radius: 5px;
        transition: none;
        color: ${c.text};
        background: ${c.background};
      }

      #custom-mem {
        padding: 5px 16px;
        border-radius: 5px;
        transition: none;
        color: ${c.text};
        background: ${c.background};
      }

      #battery {
        padding: 5px 16px;
        margin-left: 20px;
        border-radius: 5px;
        transition: none;
        color: ${c.text};
        background: ${c.background};
      }
    '';

    xdg.configFile."waybar/scripts/battery.sh".source = ./battery.sh;

    home.packages = with pkgs; [
      acpi
      dust
      pavucontrol
      pw-volume
    ];
  };
}
