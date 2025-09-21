set positional-arguments
export GUM_SPIN_SPINNER_FOREGROUND := "#D6B97F"

default: switch
switch path="/etc/nixos":
  nh os switch {{path}} -- --override-input sensible $PWD

boot path="/etc/nixos":
  nh os boot {{path}} -- --override-input sensible $PWD && reboot

dry path="/etc/nixos":
  nh os switch {{path}} -n -- --override-input sensible $PWD

test:
  #!/usr/bin/env -S bash
  has_failed=0
  for f in ./tests/*/; do
    gum spin --spinner dot --title "Testing $f..." -- \
      nix flake check $f --all-systems --override-input sensible $PWD
    if [ $? -ne 0 ]; then
      has_failed=1
      echo -en "\e[91m✗\e[0m "
    else
      echo -en "\e[92m✔\e[0m "
    fi
    echo "$f"
  done

  if [ $has_failed -ne 0 ]; then
    exit 1
  fi

check path="/etc/nixos":
  nix flake check {{path}} --override-input sensible $PWD
