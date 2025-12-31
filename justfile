set unstable := true
set shell := ["bash", "-uc"]

export GUM_SPIN_SPINNER_FOREGROUND := "#D6B97F"
builder := "nh os"
default_configuration_path := / "etc" / "nixos"
input_name := "sensible"
override_input := f"--override-input {{input_name}} $PWD"

alias default := switch

[group("build")]
switch path=default_configuration_path:
    {{ builder }} switch {{ path }} -- {{ override_input }}

[group("build")]
boot path=default_configuration_path:
    {{ builder }} boot {{ path }} -- {{ override_input }} && reboot

[group("build")]
dry path=default_configuration_path:
    {{ builder }} switch {{ path }} -n -- {{ override_input }}

[group("build")]
check path=default_configuration_path:
    nix flake check {{ path }} {{ override_input }}

test_dir := "tests"
test_src := prepend("./", shell("ls $1/*/ -dC || echo -n", test_dir))

[group("testing")]
test: prepare_tests
    echo {{ test_src }} | xargs -n 1 just test_entry

[group("testing")]
[script]
test_entry path name=file_stem(path):
    hostnames=$({{require("nix")}} flake show --json {{ path }} {{ override_input }} 2>/dev/null | {{require("jq")}} -r '.nixosConfigurations | keys[]' | tr '\n' ' ')

    if [[ "$hostnames" == "" ]]
    then
      echo "Testing {{name}}...{{ RED }} failed to parse{{ NORMAL }}"
      exit 1
    fi

    for hostname in $hostnames; do
      gum spin --spinner dot --title "Testing {{name}}#$hostname..." --show-error -- \
        {{ builder }} build-vm {{ path }} --hostname $hostname -o {{path / f"result"}} -d never -- {{ override_input }}

      if [ $? -eq 0 ]; then
        echo "Testing {{name}}#$hostname...{{ GREEN }} ok{{ NORMAL }}"
      else
        echo "Testing {{name}}#$hostname...{{ RED }} failed{{ NORMAL }}"
      fi
    done

[group("testing")]
prepare_tests:
  echo {{test_src}} \
    | tr " " "\n" \
    | xargs -I {} \
      sh -c "\
        {{require("m4")}} \
        {{test_dir / "default.m4"}} \
        {{ "{}" / "flake.m4" }} \
        {{test_dir / "flake.nix.m4"}} \
      > {{ "{}" / "flake.nix" }} && echo Wrote to {{"{}" / "flake.nix"}}"
  {{if which("alejandra") != "" {
    f"echo {{test_src}} | tr ' ' '\n' | xargs -I {} alejandra {{'{}' / 'flake.nix'}} 2>/dev/null"
  } else {""}}}
