{
  pkgs,
  config,
  lib,
  sensible_config,
  ...
}: let
  f = feature: res:
    if lib.xor config.sensible.neovim.invert_features (builtins.elem feature config.sensible.neovim.features)
    then res
    else [];
in
  sensible_config {
    condition = config.sensible.neovim.enable;
    home.home.packages = with pkgs;
      lib.flatten [
        neovim

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
        (f "c" [clang-tools])
        (f "lua" [
          lua-language-server
          stylua
        ])
        (f "nix" [
          nil
          alejandra
        ])
      ];
  }
