{
  lib,
  importUnit,
  root,
  input,
}:
lib.flatten [
  (import ./options.nix input)
  (importUnit root "cli")
]
