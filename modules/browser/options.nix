{
  pkgs,
  sensible_option,
  mkPackageSelector,
  config,
  ...
}:
sensible_option {
  browser = mkPackageSelector config {
    name = "browser";
    packages = {
      zen = {
        name = "zen";
        description = "Zen browser";
        package = pkgs.zen-browser;
      };
      firefox = {
        name = "firefox";
        description = "Firefox browser";
        package = pkgs.firefox;
      };
      chromium = {
        name = "chromium";
        description = "Chromium browser";
        package = pkgs.chromium;
      };
    };
  };
}
