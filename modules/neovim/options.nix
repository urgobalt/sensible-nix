{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    neovim = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable sensible to manage neovim for you.";
      };
      features = mkOption {
        type = with types;
          listOf (enum [
            "rust"
            "go"
            "ocaml"
            "zig"
            "gleam"
            "elixir"
            "python"
            "html-css-js"
            "tailwindcss"
          ]);
        default = [];
        description = "Programs used for development in the languages specified.";
      };
      invert_features = mkOption {
        type = types.bool;
        default = false;
        description = "Invert the features. This means that the features option now exclude features.";
      };
    };
  }
