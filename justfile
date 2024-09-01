set positional-arguments

default:
  @just --list

alias i := install
@install host:
  sudo nixos-rebuild boot --flake .#$1
  sudo reboot now

alias u := update
update:
  nix flake update

alias b := build
build:
  sudo nixos-rebuild switch

alias f := fast
fast:
  sudo nixos-rebuild switch --fast

alias t := test
test:
  sudo nixos-rebuild test --fast

alias r := rollback
rollback:
  sudo nixos-rebuild switch --rollback

alias m := metadata
metadata:
  nix flake metadata

repl:
  nixos-rebuild repl --fast
