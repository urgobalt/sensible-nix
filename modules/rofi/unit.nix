{
  config,
  pkgs,
  sensibleLib,
  ...
}:
with sensibleLib;
  (makeGraphical config {
    condition = config.sensible.rofi.enable;
    system.sensible = {
      hyprland = {
        binds = [
          "$mod,V,exec,cliphist list | rofi -dmenu | cliphist decode | wl-copy"
          "$smod,X,exec,format=$(echo -ne 'cmyk\\nhex\\nrgb\\nhsl\\nhsv' | rofi -dmenu) && sleep 0.7s && hyprpicker -af $format"
          "$mod,S,exec,echo -ne 'active\\nscreen\\noutput\\narea' | rofi -dmenu | xargs -I _ grimblast --notify --freeze copysave _ ~/pictures/screenshots/$(date +%Y-%m-%d_%H-%m-%s).png"
        ];
        launcherCommand = "rofi -show drun";
      };
      niri = {
        binds = [
          ''Mod+V { spawn "sh" "-c" "cliphist list | rofi -dmenu | cliphist decode | wl-copy"; }''
          ''Mod+Shift+X { spawn "sh" "-c" "format=\"$(echo -ne 'cmyk\\nhex\\nrgb\\nhsl\\nhsv' | rofi -dmenu)\" && sleep 0.7s && hyprpicker -af \"$format\""; }''
        ];
        launcherCommand = "rofi -show drun";
      };
    };
    home = {
      home.packages = with pkgs; [
        rofi
        cliphist
      ];
      xdg.configFile."rofi/assets.rasi".text = ''
        * {
            font:           "SourceCodePro Nerd Font 14";
        }
      '';
    };
  })
  |> sensibleConfig
