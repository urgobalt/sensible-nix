{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    ssh = {
      enable = mkEnableOption "ssh-agent and ssh client configuration";
      keyFiles = mkOption {
        type = with types; listOf str;
        default = [];
        description = "SSH identity files to use.";
      };
    };
  }
