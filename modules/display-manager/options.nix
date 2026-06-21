{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    display-manager = {
      enable = mkEnableOption "display manager with auto-login or greetd greeter";
      monitors = mkOption {
        type = with types; listOf str;
        default = [",preferred,auto,1"];
        description = "Monitors registered into the greeter's hyprland session.";
      };
      greeter = mkOption {
        type = types.enum ["greetd" "auto_login"];
        default = "auto_login";
        description = "The greeter that will be used.";
      };
      global_auto_login = mkOption {
        type = types.bool;
        default = false;
        description = ''
          This is dangerous and can give anyone access to login by just using
          another tty. If false this only allows auto-login if the tty is 1.
        '';
      };
    };
  }
