{
  pkgs,
  lib,
  config,
  ssh,
  ...
}:
with lib; let
  cfg = config.modules.ssh-agent;
in {
  options.modules.ssh-agent = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };
  config = mkIf cfg.enable {
    services.ssh-agent.enable = true;

    # Specify your SSH keys
     home.file.".ssh/config".text= lib.strings.concatStrings (map (x:"IdentityFile "+x+"\n") (ssh.keyFiles or []));
  };
}
