{lib, ...}:
with lib; {
  neovim = {
    enable = mkOption {
      type = types.boolean;
      default = false;
      description = "Enable sensible to manage neovim for you.";
    };
    features = mkOption {
      type = with types;
        listOf enumOf [
          "rust"
          "go"
          "ocaml"
          "zig"
          "gleam"
          "elixir"
          "python"
          "html-css-js"
          "tailwindcss"
        ];
      default = [];
      description = "Programs used for development in the languages specified.";
    };
  };
}
