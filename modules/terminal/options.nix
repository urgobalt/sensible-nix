{
  lib,
  sensible_option,
  sensibleLib,
  pkgs,
  ...
}:
with lib;
sensible_option {
  terminal = sensibleLib.mkPackageSelector {
    name = "terminal";
    enableDefault = true;
    packages = {
      ghostty = {
        name = "ghostty";
        description = "ghostty terminal emulator";
        package = pkgs.ghostty;
      };
      kitty = {
        name = "kitty";
        description = "kitty terminal emulator";
        package = pkgs.kitty;
      };
      wezterm = {
        name = "wezterm";
        description = "wezterm terminal emulator";
        package = pkgs.wezterm;
      };
    };
  };
}
