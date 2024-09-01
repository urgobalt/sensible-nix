{
  pkgs,
  lib,
  config,
  nvim-config,
  ...
}:
with lib; let
  cfg = config.modules.nvim;
in {
  options.modules.nvim = {enable = mkEnableOption "nvim";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      unstable.neovim

      # Rust build systems
      rustup
      cargo-info
      tailwindcss

      # Package managers
      opam
      yarn

      # Programming languages
      nodejs_22
      go
      ocaml
      unstable.zig

      # Erlang
      unstable.gleam
      erlang
      rebar3
      elixir

      # Python
      uv
      python313FreeThreading

      # Lsp
      lua-language-server
      nil
      elixir-ls
      tailwindcss-language-server
      unstable.zls

      # Linters
      eslint_d

      # Formatters
      stylua
      alejandra
    ];

    systemd.user.sessionVariables = {
      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
      MANWIDTH = 999;
    };

    xdg.configFile."nvim" = {
      # The configuration is managed through the flake and passed into home-manager as an argument
      source = nvim-config;
      recursive = true;
    };
  };
}
