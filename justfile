set positional-arguments
export GUM_CONFIRM_PROMPT_FOREGROUND := "#a4bca6"
export GUM_CONFIRM_SELECTED_BACKGROUND := "#4b7c7b"
export GUM_CONFIRM_UNSELECTED_BACKGROUND := "#2c4d4e"

default:
  just require-sudo -- nixos-rebuild switch --fast --override-input sensible-nix $PWD --show-trace

boot:
  just require-sudo -- nixos-rebuild boot --fast --override-input sensible-nix $PWD --show-trace
  reboot

check:
  nix flake check /etc/nixos --override-input sensible-nix $PWD --show-trace

eww: default
  eww daemon --restart
  eww open bar
  eww logs

hyprland: default
  hyprctl reload

require-sudo *args="":
  #!/usr/bin/env -S bash
  if [ $EUID -ne 0 ]; then
    gum confirm "This command require sudo, do you want to proceed?"
    if [ $? -eq 0 ]; then
      sudo $@
      exit 0
    fi
  fi

