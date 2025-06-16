set positional-arguments
export GUM_CONFIRM_PROMPT_FOREGROUND := "#a4bca6"
export GUM_CONFIRM_SELECTED_BACKGROUND := "#4b7c7b"
export GUM_CONFIRM_UNSELECTED_BACKGROUND := "#2c4d4e"

default: switch
switch path="/etc/nixos":
  nh os switch {{path}} -- --override-input sensible $PWD

boot path="/etc/nixos":
  nh os boot {{path}} -- --override-input sensible $PWD
  reboot

[working-directory("./test_system")]
test:
  nix flake check --override-input sensible $PWD/.. --impure

check path="/etc/nixos":
  nix flake check {{path}} --override-input sensible $PWD
