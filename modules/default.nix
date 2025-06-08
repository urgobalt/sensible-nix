{
  lib,
  importUnit,
  root,
}: [
  ./options.nix
  (importUnit root "cli")
]
