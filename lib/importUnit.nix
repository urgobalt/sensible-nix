input: root: directory: let
  unitUtils = rec {
    unit = (import ./unit.nix) input;
    units = (import ./units.nix) input.lib unit;
    optionCall = (import ./optionCall.nix) input;
  };
in [
  (unitUtils.optionCall (import "${root}/modules/${directory}/options.nix"))
  (import "${root}/modules/${directory}/unit.nix" unitUtils)
]
