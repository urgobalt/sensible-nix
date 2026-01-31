set unstable := true
set dotenv-load := true
set positional-arguments := true
set shell := ["bash", "-uc"]
set script-interpreter := ["shell", "--norc", "--"]

# Global configurations for all the commands
builder := "nh os"
default_configuration_path := env("CONFIGURATION_PATH", / "etc" / "nixos")
input_name := env("INPUT_NAME", "sensible")
experimental_flags := "nix-command flakes pipe-operators"
nix_flake_flags := f"--override-input {{input_name}} $PWD --extra-experimental-features '{{experimental_flags}}'"

alias default := switch

# Build and switch to a new configuration
[group("install")]
switch path=default_configuration_path *args="":
    {{ builder }} switch {{ path }} -- {{ nix_flake_flags }} {{ args }}

# Build and create a boot entry for the new configuration
[group("install")]
boot path=default_configuration_path *args="":
    {{ builder }} boot {{ path }} -- {{ nix_flake_flags }} {{ args }} && reboot

# Build the configuration without applying it to the system in any form
[group("install")]
dry path=default_configuration_path *args="":
    {{ builder }} switch {{ path }} -n -- {{ nix_flake_flags }} {{ args }}

# Check the configuration
[group("development")]
check path=default_configuration_path *args="-L":
    nix flake check {{ path }} {{ nix_flake_flags }} {{ args }}

# Create a repl for the current system defined by the 'path' input
[group("development")]
repl path=default_configuration_path *args="":
    nix repl {{ path }}#nixosConfigurations."{{ shell("hostname") }}" {{ nix_flake_flags }} {{ args }}

# Create ctags file for development
[group("development")]
tags:
    nix-doc tags

# Search for symbols within the project
[group("development")]
search_symbol regex:
    nix-doc search "{{regex}}"

# Test config
test_dir := "tests"
test_src := prepend("./", shell("ls $1/*/ -dC || echo -n", test_dir))
test_hostname := "test"

# Run all defined tests
[group("testing")]
test: prepare_tests
    echo {{ test_src }} | xargs -n 1 just test_entry

# Run specified test
[group("testing")]
[script]
test_entry path name=file_stem(path) *args="":
    gum spin --spinner dot --title "Testing {{ name }}..." --show-error -- \
      {{ builder }} build-vm {{ path }} --hostname {{ test_hostname }} -o {{ path / f"result" }} -d never -- {{ nix_flake_flags }} {{ args }} --show-trace

    if [ $? -eq 0 ]; then
      echo "Testing {{ name }}...{{ GREEN }} ok{{ NORMAL }}"
    else
      echo "Testing {{ name }}...{{ RED }} failed{{ NORMAL }}"
    fi

# Prepare the tests via macros
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
