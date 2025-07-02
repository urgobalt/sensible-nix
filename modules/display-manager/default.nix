{
  pkgs,
  lib,
  config,
  user,
  wallpaper,
  colors,
  ...
}:
with lib; let
  cfg = config.modules.display-manager;
  c = colors.regular;
  autostart-hyprland = pkgs.writeShellScriptBin "autostart-hyprland" ''
    if [ -z "$DISPLAY" ] && [ "$(fgconsole 2>/dev/null || echo 1)" = "1" ]; then
        echo "launching"
        exec (hyprland &; login ${user})
    else
      echo "failed to launch"
    fi
  '';
in {
  options.modules.display-manager = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable the display manager.";
    };
    monitors = mkOption {
      type = types.listOf types.str;
      default = [",preferred,auto,1"];
      description = "The monitors registred into hyprland.";
    };
    greeter = mkOption {
      type = with types; enum ["greetd" "auto_login"];
      default = "auto_login";
      description = "The greeter that will be used.";
    };
    global_auto_login = mkOption {
      type = types.bool;
      default = false;
      description = "This is dangerous and can give anyone access to login by just using another tty, if false this only allows auto_login if it is set and the tty is 1";
    };
  };
  config = mkIf cfg.enable (mkMerge [
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
      # https://github.com/NixOS/nixpkgs/pull/108294
      boot.initrd.verbose = lib.mkDefault false;
      boot.plymouth.enable = lib.mkDefault true;
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };
    }
    (
      mkIf
      (cfg.greeter == "auto_login" && !cfg.global_auto_login)
      {
        systemd.services."getty@tty1" = {
          enable = true;
          unitConfig = {
          };
          overrideStrategy = "asDropin";
          serviceConfig = {
            ExecStart = lib.mkForce [
              ""
              "${pkgs.util-linux}/bin/agetty --autologin ${user} --noclear %I $TERM"
            ];
          };
        };
        environment.loginShellInit = ''sh ${autostart-hyprland}/bin/autostart-hyprland'';
      }
    )
    (mkIf
      (cfg.greeter == "auto_login" && cfg.global_auto_login)
      {
        services.getty.autologinUser = lib.mkDefault user;
        environment.loginShellInit = ''sh ${autostart-hyprland}/bin/autostart-hyprland'';
      })
    (
      mkIf (cfg.greeter == "greetd") {
        environment.systemPackages = with pkgs; [regreet adwaita-icon-theme-legacy];
        environment.etc = {
          "greetd/regreet.toml".source = import ./regreet.nix {inherit pkgs wallpaper;};
          "greetd/regreet.css".text = import ./regreet-css.nix {colors = c;};
          "greetd/hyprland.conf".text = import ./hyprland.nix {
            inherit pkgs lib;
            monitors = cfg.monitors;
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
      }
    )
  ]);
}
