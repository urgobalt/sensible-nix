input: root: directory: let
  unitUtils = rec {
    unit = (import ./unit.nix) input;
    units = (import ./units.nix) input.lib unit;
  };
in [
  (import "${root}/modules/${directory}/options.nix" input)
  (import "${root}/modules/${directory}/unit.nix" unitUtils)
]
