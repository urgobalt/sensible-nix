{
  config,
  pkgs,
  sensibleLib,
  ...
}:
let
  c = config.lib.stylix.colors;
in
with sensibleLib;
  (makeGraphical config {
    condition = config.sensible.walker.enable;
    system.sensible = {
      hyprland = {
        binds = [
          "$mod,V,exec,cliphist list | walker -d | cliphist decode | wl-copy"
          "$smod,X,exec,format=$(echo -ne 'cmyk\\nhex\\nrgb\\nhsl\\nhsv' | walker -d) && sleep 0.7s && hyprpicker -af $format"
        ];
        launcherCommand = "walker";
      };
      niri = {
        binds = [
          ''Mod+V { spawn "sh" "-c" "cliphist list | walker -d | cliphist decode | wl-copy"; }''
          ''Mod+Shift+X { spawn "sh" "-c" "format=\"$(echo -ne 'cmyk\\nhex\\nrgb\\nhsl\\nhsv' | walker -d)\" && sleep 0.7s && hyprpicker -af \"$format\""; }''
        ];
        launcherCommand = "walker";
      };
    };
    home = {
      packages = with pkgs; [
        walker
        cliphist
      ];
      xdg.configFile."walker/config.json".text = builtins.toJSON {
        font = "SourceCodePro Nerd Font 14";
        theme = {
          background = "#${c.base00}";
          foreground = "#${c.base05}";
          accent = "#${c.base0D}";
          border = "#${c.base02}";
          selected = "#${c.base02}";
          text = "#${c.base05}";
        };
      };
    };
  })
  |> sensibleConfig
