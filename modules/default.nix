{
  lib,
  importUnits,
  root,
}:
lib.flatten (importUnits root [
  "cli"
  "secrets"
  "neovim"
  "hyprland"
])
