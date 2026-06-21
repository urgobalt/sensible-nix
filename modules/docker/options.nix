{
  lib,
  sensible_option,
  ...
}:
with lib;
sensible_option {
  docker = {
    enable = mkEnableOption "rootless Docker mode with user-level socket access";
  };
}
