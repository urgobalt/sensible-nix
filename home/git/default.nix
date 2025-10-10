{
  pkgs,
  lib,
  config,
  full-name,
  email,
  ...
}:
with lib; let
  cfg = config.modules.git;
in {
  options.modules.git = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable git on your system.";
    };
  };
  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      settings = {
        core = {
          editor = "nvim";
          fsmonitor = true;
          untrackedCache = true;
        };
        gpg.format = "ssh";
        safe.directory = [
          "/etc/nixos"
        ];
        push.autoSetupRemote = true;
        rerere.enabled = true;
        column.ui = "auto";
        branch.sort = "-committerdate";
        fetch.writeCommitGraph = true;
      };
      settings = {
        user.name = full-name;
        user.email = email;
        aliases = {
          fp = "push --force-with-lease";
        };
      };
    };
  };
}
