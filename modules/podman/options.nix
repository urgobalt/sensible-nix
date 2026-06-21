{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    podman = {
      enable = mkEnableOption "podman container runtime";
    };
  }
