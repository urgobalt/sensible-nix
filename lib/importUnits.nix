input: root: units: let
  unitUtils = rec {
    unit = (import ./unit.nix) input;
    units = (import ./units.nix) input.lib unit;
    optionCall = (import ./optionCall.nix) input;
  };
  mergeFunction = acc: nextSet: input.lib.recursiveUpdate acc nextSet;
  importUnitsFunction = directory:
    input.lib.foldl' mergeFunction {} (input.lib.flatten [
      (unitUtils.optionCall (import "${root}/modules/${directory}/options.nix"))
      (import "${root}/modules/${directory}/unit.nix" unitUtils)
    ]);
in
  map importUnitsFunction units
