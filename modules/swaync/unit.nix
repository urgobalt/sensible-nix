{
  config,
  pkgs,
  sensibleLib,
  ...
}:
with sensibleLib;
  (makeGraphical config {
    condition = config.sensible.swaync.enable;
    home = {
      home.packages = [pkgs.swaynotificationcenter];
      xdg.configFile."swaync/config.json".text = import ./config.nix;
      xdg.configFile."swaync/style.css".text = import ./style.nix {config = config;};
    };
  })
  |> sensibleConfig
