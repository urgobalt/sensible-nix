{
  lib,
  pkgs,
  config,
  sensible_option,
  mkPackageSelector,
  ...
}: let
  # [ "name" "description" package ]
  packageOptions = packages: let
    packageAttrs = with lib;
      listToAttrs (
        map (
          pkg:
            nameValuePair (builtins.elemAt pkg 0) {
              enable = mkEnableOption (builtins.elemAt pkg 1);
              package = mkOption {
                type = types.package;
                default = builtins.elemAt pkg 2;
                description = "The package for ${builtins.elemAt pkg 0}";
              };
            }
        )
        packages
      );
  in
    with lib;
      recursiveUpdate packageAttrs {
        custom = {
          enable = mkEnableOption "custom";
          package = mkOption {
            type = with types; nullOr package;
            default = null;
            description = "Custom browser";
          };
        };
        default = mkOption {
          type = types.enum (map (p: p.${0}) packages);
          default =
            if (length packages > 0)
            then (head packages).${0}
            else null;
          description = "The default to use.";
        };

        package = mkOption {
          type = types.package;
          internal = true;
          readOnly = true;
          default =
            config.sensible.browser.${config.sensible.browser.default}.package;
        };
      };
in {
  options.sensible.browser = packageOptions [
    ["zen" "Zen browser" pkgs.zen-browser]
    ["firefox" "Firefox browser" pkgs.firefox]
    ["chromium" "Chromium browser" pkgs.chromium]
  ];
}
