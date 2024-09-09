set positional-arguments

default:
  @just --list

core:
  sudo nixos-rebuild switch --fast --override-input sensible-nix $PWD

eww: core
  eww daemon --restart
  eww open bar
  eww logs

hyprland: core
  hyprctl reload
