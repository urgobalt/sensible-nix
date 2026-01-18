{
  pkgs,
  sensible_option,
  sensibleLib,
  config,
  ...
}:
sensible_option {
  terminal = sensibleLib.mkPackageSelector config {
    name = "terminal";
    enableDefault = true;

    packages = {
      ghostty = {
        name = "ghostty";
        description = "Ghostty terminal";
        package = pkgs.ghostty;
      };
      kitty = {
        name = "kitty";
        description = "Kitty terminal";
        package = pkgs.kitty;
      };
      wezterm = {
        name = "wezterm";
        description = "Wezterm terminal";
        package = pkgs.unstable.wezterm;
      };
    };
  };
}
