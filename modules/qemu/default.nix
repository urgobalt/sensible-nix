{
  pkgs,
  lib,
  config,
  user,
  ...
}:
with lib; let
  cfg = config.modules.qemu;
in {
  options.modules.qemu = {enable = mkEnableOption "qemu";};
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      virtmanager
      looking-glass-client
      scream-recievers
    ];

    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        ovmf.enable = true;
        runAsRoot = true;
      };
      onBoot = "ignore";
      onShutdown = "shutdown";
    };

    systemd.tmpfiles.rules = [
      "f /dev/shm/looking-glass 0660 ${user} qemu-libvirtd -"
      "f /dev/shm/scream 0660 ${user} qemu-libvirtd -"
    ];

    systemd.user.services.scream-ivshmem = {
      enable = true;
      description = "Scream IVSHMEM";
      serviceConfig = {
        ExecStart = "${pkgs.scream-recievers}/bin/scream-ivshmem-pulse /dev/shm/scream";
        Restart = "always";
      };
      wantedBy = ["multi-user.target"];
      requires = ["pulseaudio.service"];
    };
  };
}
