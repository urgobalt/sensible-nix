set positional-arguments

default:
  sudo nixos-rebuild switch --fast --override-input sensible-nix $PWD --show-trace

boot:
  sudo nixos-rebuild boot --fast --override-input sensible-nix $PWD --show-trace
  reboot

eww: default
  eww daemon --restart
  eww open bar
  eww logs

hyprland: default
  hyprctl reload
