{unit, ...}:
unit ({
  pkgs,
  config,
  lib,
  ...
}: let
  f = feature: res:
    if builtins.elem feature config.sensible.neovim.features
    then res
    else [];
in {
  condition = config.sensible.neovim.enable;
  home.packages = with pkgs;
    lib.flatten [
      neovim

      lua-language-server
      stylua

      nil
      alejandra

      emmet-ls
      eslint_d

      (f "rust" [rustup cargo-info])
      (f "go" [go gopls])
      (f "ocaml" [ocaml ocamlPackages.ocaml-lsp])
      (f "zig" [zig zls])
      (f "gleam" [gleam erlang rebar3])
      (f "elixir" [elixir-ls elixir erlang rebar3])
      (f "python" [
        python312Packages.python-lsp-server
        python312Packages.pylsp-rope
      ])
      (f "html-css-js" [vscode-langservers-extracted])
      (f "tailwindcss" [
        tailwindcss
        tailwindcss-language-server
      ])
    ];
})
