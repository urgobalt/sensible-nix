{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    tmux = {
      enable = mkEnableOption "tmux terminal multiplexer";
    };
  }
