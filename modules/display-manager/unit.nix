{
  config,
  pkgs,
  lib,
  user,
  sensibleLib,
  ...
}:
let
  cfg = config.sensible.display-manager;
  c = config.lib.stylix.colors;
  # TODO: Enable this for all configurable window managers
  autostart-hyprland = pkgs.writeShellScriptBin "autostart-hyprland" ''
    if [ -z "$DISPLAY" ] && [ "$(fgconsole 2>/dev/null || echo 1)" = "1" ]; then
        echo "launching"
        exec ${lib.getExe config.home-manager.users.${user}.wayland.windowManager.hyprland.package} || login ${user}
    else
      echo "failed to launch"
    fi
  '';
in
  sensibleLib.sensibleConfig {
    condition = cfg.enable;
    system = lib.mkMerge [
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
        programs.hyprland = {
          enable = true;
          xwayland.enable = true;
        };
      }
      (lib.mkIf (cfg.greeter == "auto_login" && !cfg.global_auto_login) {
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
        environment.loginShellInit = ''sh ${autostart-hyprland}/bin/autostart-hyprland'';
      })
      (lib.mkIf (cfg.greeter == "auto_login" && cfg.global_auto_login) {
        services.getty.autologinUser = lib.mkDefault user;
        environment.loginShellInit = ''sh ${autostart-hyprland}/bin/autostart-hyprland'';
      })
      (lib.mkIf (cfg.greeter == "greetd") {
        environment.systemPackages = with pkgs; [regreet adwaita-icon-theme-legacy];
        environment.etc = {
          "greetd/regreet.toml".source = (pkgs.formats.toml {}).generate "regreet.toml" {
            background = {
              path = config.sensible.wallpaper.resolved or null;
              fit = "Cover";
            };
            commands = {
              reboot = ["systemctl" "reboot"];
              shutdown = ["systemctl" "poweroff"];
            };
            appearance.greeting_msg = "I use NixOS btw.";
            GTK = {
              application_prefer_dark_theme = true;
              icon_theme_name = "Adwaita";
            };
          };
          "greetd/regreet.css".text = ''
            @define-color theme_bg_color ${c.base00};

            * { border: 0px solid black; }

            .background { color: ${c.base05}; }

            button { background-color: ${c.base01}; background-image: none; }

            button.text-button { background-color: ${c.base01}; background-image: none; font-weight: bold; }

            button.text-button:hover { background-color: ${c.base02}; }

            button.default { color: ${c.base0C}; }

            button.destructive-action { color: ${c.base08}; }

            combobox button.combo { background-color: ${c.base01}; background-image: none; }

            combobox arrow { min-width: 16px; min-height: 16px; padding: 1.5px; }
          '';
          "greetd/hyprland.conf".text = lib.hm.generators.toHyprconf {
            attrs = {
              exec-once = ["${lib.getExe pkgs.regreet}; hyprctl dispatch exit"];
              monitor = cfg.monitors;
              misc = {
                disable_splash_rendering = true;
                disable_hyprland_logo = true;
              };
              animations = {
                enabled = 1;
                animation = ["windows,0"];
              };
            };
          };
        };
        services.greetd = {
          enable = true;
          settings = {
            default_session = {
              command = "${lib.getExe config.programs.hyprland.package} -c /etc/greetd/hyprland.conf";
            };
          };
        };
        systemd.tmpfiles.rules = [
          "d /var/log/regreet 0755 greeter greeter - -"
          "d /var/cache/regreet 0755 greeter greeter - -"
        ];
      })
    ];
  }
