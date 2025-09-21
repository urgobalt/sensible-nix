set positional-arguments
export GUM_CONFIRM_PROMPT_FOREGROUND := "#a4bca6"
export GUM_CONFIRM_SELECTED_BACKGROUND := "#4b7c7b"
export GUM_CONFIRM_UNSELECTED_BACKGROUND := "#2c4d4e"

default: switch
switch path="/etc/nixos":
  nh os switch {{path}} -- --override-input sensible $PWD

boot path="/etc/nixos":
  nh os boot {{path}} -- --override-input sensible $PWD && reboot

dry path="/etc/nixos":
  nh os switch {{path}} -n -- --override-input sensible $PWD

test:
  #!/usr/bin/env -S bash -x
  for f in ./tests/*/; do
    nix flake check $f --all-systems --override-input sensible $PWD
  done

check path="/etc/nixos":
  nix flake check {{path}} --override-input sensible $PWD
