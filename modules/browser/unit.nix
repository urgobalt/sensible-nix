{
  config,
  ...
}: {
  imports = [
    ./chromium.nix
    ./firefox.nix
    ./zen.nix
  ];
  sensible.browser.package = config.sensible.browser.${config.sensible.browser.default}.package;
}
