{
  pkgs,
  sensible_option,
  sensibleLib,
  ...
}:
sensible_option {
  browser = sensibleLib.mkPackageSelector {
    name = "browser";
    enableDefault = true;
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
