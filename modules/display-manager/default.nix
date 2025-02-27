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
in {
  options.modules.display-manager = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable the sddm display manager.";
    };
    greeter = mkOption {
      type = with types; enum ["sddm" "greetd"];
      default = "greetd";
      description = "The greeter that will be used.";
    };
    autologin = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable autologin for the current user.";
      };
    };
    theme = {
      package = mkOption {
        type = types.package;
        default = pkgs.sddm-glassy;
        description = "The package that contain the theme.";
      };
      name = mkOption {
        type = types.str;
        default = "sddm-glassy";
        description = "The name of the package. It is the name of the folder within /share/sddm/themes.";
      };
      extraPackages = mkOption {
        type = with types; listOf package;
        default = with pkgs.libsForQt5; [
          qt5.qtgraphicaleffects
          plasma-workspace
          plasma-framework
          kconfig
        ];
        description = "Extra Qt plugins and/or QML libraries to add to the environment.";
      };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = [cfg.theme.package];
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };
      boot.kernelParams = [
        "quiet"
        "splash"
        "vga=current"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
      ];
      boot.consoleLogLevel = 0;
      # https://github.com/NixOS/nixpkgs/pull/108294
      boot.initrd.verbose = false;
      boot.plymouth.enable = true;
    }
    (mkIf (cfg.greeter == "sddm") {
      services.displayManager.sddm = {
        enable = true;
        extraPackages = cfg.theme.extraPackages;
        theme = cfg.theme.name;
        wayland.enable = true;
      };
    })
    (
      mkIf (cfg.greeter == "greetd") {
        environment.systemPackages = with pkgs; [regreet adwaita-icon-theme-legacy];
        environment.etc = {
          "greetd/regreet.toml".source = import ./regreet.nix {inherit pkgs wallpaper;};
          "greetd/regreet.css".text = import ./regreet-css.nix {colors = c;};
          "greetd/hyprland.conf".text = import ./hyprland.nix {inherit pkgs lib;};
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
