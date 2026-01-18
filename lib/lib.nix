{
  lib,
  user,
}: rec {
  /*
  Sensible Config

  The core component of the sensible configuration system. It simplifies the
  enabling and disabling of different functionalities within both home-manager
  and core nixos within the same attribute set. The attribute set of a unit should be of the shape:

  ```nix
  {
    condition = ...; # Boolean that controls the lib.mkIf for home and system
    system = { ... }; # The nixos configuration
    home = { ... }; The home manager configuration
    assertions = [ { assertion = ...; message = ...; } ]; # Nixos assertions
    warnings = [ ... ]; # List of warnings (strings)
  }
  ```
  */

  sensibleConfig = unit: let
    optionalWithDefault = default: name:
      if builtins.hasAttr name unit
      then unit.${name}
      else default;
    optional = optionalWithDefault {};
    optionals = optionalWithDefault [];
  in {
    imports = optionals "imports";
    config =
      lib.mkIf unit.condition
      <| {
        assertions = optionals "assertions";
        warnings = optionals "warnings";
        home-manager.users.${user} = lib.mkIf unit.condition <| optional "home";
      }
      // optional "system";
  };

  /*
  Conditions

  Sensible nix unit based configurations utilities for adding special and
  generic conditions.
  */

  addCondition = unit: condition:
    unit
    // {
      condition =
        if builtins.hasAttr "condition" unit
        then (unit.condition) && condition
        else condition;
    };

  # Add the restriction that a graphical environment must be installed for the
  # following unit to be enabled.
  makeGraphical = config: unit: addCondition unit config.sensible.graphical_environment;

  /*
  Package Selector

  A package in sensible nix is a super simple configuration option that only
  contains enable and package. You are able to enable the setting and switch
  out the default package for a custom one, that is the only funcitonality that
  a package should need to customize, the sensible nix configuration should
  provide the rest of the defaults for that package in order for it to work
  with the rest of the applications installed on your system. That is the
  ideology of sensible nix.
  */

  mkPackageSelector = {
    name,
    packages,
    enableDefault ? false,
  }:
    with lib; let
      packageList = builtins.attrNames packages;
      packageOptions = attrsets.genAttrs packageList (name: {
        enable = mkOption {
          type = types.bool;
          default = false;
          example = true;
          description = "Enable ${packages.${name}.description}";
        };
        package = mkOption {
          type = types.package;
          default = packages.${name}.package;
          description = "Package for ${packages.${name}.description}";
        };
      });
      defaultOption =
        if enableDefault
        then {
          default = mkOption {
            type = types.enum packageList;
            default = builtins.head packageList;
            example = builtins.tail packageList;
            description = "The default ${name}";
          };
        }
        else {};
    in
      packageOptions // defaultOption;

  # Lightweight utility for getting the default package from a package selector
  getDefaultPackage = config: config.${config.default}.package;
}
