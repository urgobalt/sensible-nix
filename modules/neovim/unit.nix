{
  pkgs,
  config,
  lib,
  sensibleLib,
  ...
}: let
  feat = feature: res:
    if lib.xor config.sensible.neovim.invert_features (builtins.elem feature config.sensible.neovim.features)
    then res
    else [];
in
  sensibleLib.sensibleConfig {
    condition = config.sensible.neovim.enable;
    home.home.packages = with pkgs;
      lib.flatten [
        neovim

        emmet-ls
        eslint_d

        (feat "rust"        [rustup cargo-info])
        (feat "go"          [go gopls])
        (feat "ocaml"       [ocaml ocamlPackages.ocaml-lsp])
        (feat "zig"         [zig zls])
        (feat "gleam"       [gleam erlang rebar3])
        (feat "elixir"      [elixir-ls elixir erlang rebar3])
        (feat "python"      [python312Packages.python-lsp-server python312Packages.pylsp-rope])
        (feat "html-css-js" [vscode-langservers-extracted])
        (feat "tailwindcss" [tailwindcss tailwindcss-language-server])
        (feat "c"           [clang-tools])
        (feat "lua"         [lua-language-server stylua])
        (feat "nix"         [nil alejandra])
      ];
  }
