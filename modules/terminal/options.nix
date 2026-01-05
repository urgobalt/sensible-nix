{
  pkgs,
  sensible_option,
  mkPackageSelector,
  config,
  ...
}:
sensible_option {
  terminal = mkPackageSelector config {
    name = "terminal";

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
