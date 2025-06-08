root: directory: let
  unit = import ./unit.nix;
in [
  "${root}/modules/${directory}/options.nix"
  (import "${root}/modules/${directory}/unit.nix" unit)
]
