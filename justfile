set positional-arguments

default:
  sudo nixos-rebuild switch --fast --override-input sensible-nix $PWD

boot:
  sudo nixos-rebuild boot --fast --override-input sensible-nix $PWD
  reboot

eww: default
  eww daemon --restart
  eww open bar
  eww logs

hyprland: default
  hyprctl reload
