{
  config,
  pkgs,
  lib,
  user,
  sensibleLib,
  ...
}:
let
  autostart-wm = pkgs.writeShellScriptBin "autostart-wm" ''
    if [ -z "$DISPLAY" ] && [ "$(fgconsole 2>/dev/null || echo 1)" = "1" ]; then
        echo "launching window-manager"
        exec ${lib.getExe config.sensible.window_manager} || login ${user}
    else
      echo "failed to launch"
    fi
  '';
in sensibleLib.sensibleConfig {
  condition = config.sensible.graphical_environment;
  import = [
    {
      boot.kernelParams = lib.mkDefault [
        "quiet"
        "splash"
        "vga=current"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
      ];
      boot.consoleLogLevel = lib.mkDefault 0;
      boot.initrd.verbose = lib.mkDefault false;
      boot.plymouth.enable = lib.mkDefault true;
    }
    (lib.mkIf (!config.sensible.display-manager.global_auto_login) {
      systemd.services."getty@tty1" = {
        enable = true;
        overrideStrategy = "asDropin";
        serviceConfig = {
          ExecStart = lib.mkForce [
            ""
            "bash -c \"${pkgs.util-linux}/bin/agetty --autologin ${user} --noclear %I $TERM\""
          ];
        };
      };
      environment.loginShellInit = ''sh ${autostart-wm}/bin/autostart-wm'';
    })
    (lib.mkIf config.sensible.display-manager.global_auto_login {
      services.getty.autologinUser = lib.mkDefault user;
      environment.loginShellInit = ''sh ${autostart-wm}/bin/autostart-wm'';
    })
  ];
}
