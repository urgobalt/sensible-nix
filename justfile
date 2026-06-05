set positional-arguments
export GUM_CONFIRM_PROMPT_FOREGROUND := "#a4bca6"
export GUM_CONFIRM_SELECTED_BACKGROUND := "#4b7c7b"
export GUM_CONFIRM_UNSELECTED_BACKGROUND := "#2c4d4e"

default:
  nh os switch -- --override-input sensible-nix $PWD

reboot:
  nh os boot -- --override-input sensible-nix $PWD && reboot

boot:
  nh os boot --  --override-input sensible-nix $PWD

upgrade:
  nh os switch --  --override-input sensible-nix $PWD --upgrade

check:
  nix flake check /etc/nixos --override-input sensible-nix $PWD --show-trace --all-systems 

eww: default
  eww daemon --restart
  eww open bar
  eww logs

hyprland: default
  hyprctl reload
