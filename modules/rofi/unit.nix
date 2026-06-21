{
  config,
  pkgs,
  sensibleLib,
  ...
}:
with sensibleLib;
  (makeGraphical config {
    condition = config.sensible.rofi.enable;
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
