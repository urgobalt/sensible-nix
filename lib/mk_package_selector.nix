{
  lib,
  config,
  ...
}: let
  mkPackageSelector = {
    name,
    packages,
    enableCustom ? true,
    enableDefault ? true,
  }: let
    cfg = config.sensible.${name};
    packagesList = lib.attrValues packages;
    enabledPackages = lib.filter (p: cfg.${p.name}.enable) packagesList;

    packageAttrs = with lib;
      listToAttrs (
        map (
          pkg:
            nameValuePair pkg.name {
              enable = mkEnableOption pkg.description;
              package = mkOption {
                type = types.package;
                default = pkg.package;
                description = "The package for ${pkg.name}";
              };
            }
        )
        packagesList
      );

    customOption =
      if enableCustom
      then {
        custom = {
          enable = lib.mkEnableOption "custom ${name}";
          package = lib.mkOption {
            type = with lib.types; nullOr package;
            default = null;
            description = "Custom ${name} package";
          };
        };
      }
      else {};

    defaultOption =
      if enableDefault
      then {
        default = lib.mkOption {
          type = with lib.types;
            nullOr (enum (map (p: p.name) enabledPackages));
          default =
            if (lib.length enabledPackages > 0)
            then (lib.head enabledPackages).name
            else null;
          description = "The default ${name} to use. Only enabled packages are available.";
        };
        package = lib.mkOption {
          type = with lib.types; nullOr package;
          internal = true;
          readOnly = true;
          default =
            if cfg.default != null && cfg.${cfg.default}.enable
            then cfg.${cfg.default}.package
            else null;
        };
      }
      else {};
  in
    lib.recursiveUpdate packageAttrs (lib.recursiveUpdate customOption defaultOption);
in {
  mkPackageSelector = mkPackageSelector;
}
