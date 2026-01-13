{
  lib,
  user,
}: rec {
  addCondition = unit: condition:
    unit
    // {
      condition =
        if builtins.hasAttr "condition" unit
        then (unit.condition) || condition
        else condition;
    };
  makeGraphical = config: unit: addCondition unit config.sensible.graphical_environment;
  mkPackageSelector = import ./mk_package_selector.nix lib;
  sensibleConfig = import ./sensible_config.nix lib user;
}
