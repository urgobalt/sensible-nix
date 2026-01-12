set unstable
set dotenv-load
set positional-arguments
set shell := ["bash", "-uc"]
set script-interpreter := ["shell", "--norc", "--"]
export GUM_SPIN_SPINNER_FOREGROUND := "#D6B97F"

builder := "nh os"

default_configuration_path := env("CONFIGURATION_PATH", / "etc" / "nixos")
input_name := env("INPUT_NAME", "sensible")
override_input := f"--override-input {{input_name}} $PWD"

test_dir := "tests"
test_src := prepend("./", shell("ls $1/*/ -dC || echo -n", test_dir))
test_hostname := "test"

alias default := switch

[group("install")]
switch path=default_configuration_path:
    {{ builder }} switch {{ path }} -- {{ override_input }}

[group("install")]
boot path=default_configuration_path:
    {{ builder }} boot {{ path }} -- {{ override_input }} && reboot

[group("install")]
dry path=default_configuration_path:
    {{ builder }} switch {{ path }} -n -- {{ override_input }}

[group("install")]
check path=default_configuration_path:
    nix flake check {{ path }} {{ override_input }}

[group("development")]
repl path=default_configuration_path:
    nix repl {{ path }}#nixosConfigurations."{{ shell("hostname") }}" {{ override_input }}

[group("development")]
tags:
    nix-doc tags

[group("development")]
search_symbol regex:
    nix-doc search "{{regex}}"

[group("testing")]
test: prepare_tests
    echo {{ test_src }} | xargs -n 1 just test_entry

[group("testing")]
[script]
test_entry path name=file_stem(path):
    gum spin --spinner dot --title "Testing {{ name }}..." --show-error -- \
      {{ builder }} build-vm {{ path }} --hostname {{test_hostname}} -o {{ path / f"result" }} -d never -- {{ override_input }} --show-trace

    if [ $? -eq 0 ]; then
      echo "Testing {{ name }}...{{ GREEN }} ok{{ NORMAL }}"
    else
      echo "Testing {{ name }}...{{ RED }} failed{{ NORMAL }}"
    fi

[group("testing")]
prepare_tests:
    echo {{ test_src }} \
      | tr " " "\n" \
      | xargs -I {} \
        sh -c "\
          {{ require("m4") }} \
          {{ test_dir / "default.m4" }} \
          {{ test_dir / "test_config.m4" }} \
          {{ test_dir / "flake.nix.m4" }} \
        > {{ "{}" / "flake.nix" }} && echo Wrote to {{ "{}" / "flake.nix" }}"
    {{ if which("alejandra") != "" { f"echo {{test_src}} | tr ' ' '\n' | xargs -I {} alejandra {{'{}' / 'flake.nix'}} 2>/dev/null" } else { "" } }}
