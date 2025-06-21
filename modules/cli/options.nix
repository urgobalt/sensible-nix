{
  lib,
  pkgs,
  ...
}:
with lib; {
  shell = {
    name = mkOption {
      type = types.enum ["fish" "bash" "zsh"];
      default = "fish";
      description = "The default shell that is used by the user.";
    };
    package = mkOption {
      type = types.package;
      default = pkgs.fish;
      description = "The default shell package that is used by the user. Automatically set, but overridable.";
    };
  };
  sysinfo = {
    name = mkOption {
      type = types.enum ["none" "pfetch" "fastfetch"];
      default = "none";
      description = "The system information tool that is automatically called by the shell at init.";
    };
    package = mkOption {
      type = types.package;
      description = "The default sysinfo package that is used. Automatically set, but overridable.";
    };
  };
  starship = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Customizable shell that works on bash, zsh, fish and many others.";
    };
  };
}
