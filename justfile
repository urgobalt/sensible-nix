set positional-arguments

default:
  @just --list

core:
  nix flake update /etc/nixos
  sudo nixos-rebuild switch --fast

eww: core
  eww daemon --restart
  eww open bar
  eww logs
