{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    display-manager = {
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
