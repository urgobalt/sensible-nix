{
  lib,
  config,
  pkgs,
  wallpaper,
  colors,
  ...
}:
with lib; let
  cfg = config.modules.hyprland;
  c = colors.zero_prefix;
in {
  options.modules.hyprland = {
    enable = mkEnableOption "hyprland";
    monitors = mkOption {
      type = types.listOf types.str;
      default = [",preferred,auto,1"];
      description = "The monitors registred into hyprland.";
    };
    hypridle = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "using hypridle to autmatically lock on idle";
      };
    };
    hyprlock = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "locking greeter";
      };
      auto_start = mkOption {
        description = "auto starting hyprlock upon entering hyprland";
        type = types.bool;
        default = true;
      };
    };
    avatar = mkOption {
      type = types.path;
      default = ./../../assets/nix-snowflake-rainbow.png;
      description = "The avatar for hyprlock";
    };
    layout = mkOption {
      type = with types; enum ["master" "dwindle"];
      default = "master";
      description = "The initial layout that hyprland has at boot. May be changed using dispatchers.";
    };
    terminal = mkOption {
      type = with types; package;
      default = pkgs.kitty;
      description = "The terminal that is used to run most terminal dependant commands and binds in hyprland.";
    };
    browser = mkOption {
      type = with types; package;
      default = pkgs.firefox;
      description = "the browser that is used by default in hyprland commands and binds.";
    };
    live_wallpaper = {
      enable = mkOption {
        description = "Live wallpaper using mpvpaper";
        type = types.bool;
        default = false;
      };
      auto_start = mkOption {
        description = "autostart live wallpaper using mpvpaper";
        type = types.bool;
        default = true;
      };
      monitors = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "The monitors registred into mpvpaper.";
      };
      default = mkOption {
        type = types.str;
        default = "";
        description = "The monitors registred into mpvpaper.";
      };
    };

    cursor = {
      package = mkOption {
        type = types.package;
        default = pkgs.rose-pine-hyprcursor;
        description = "The package that contain directories with hyprcursor themes at '$out/share/icons'.";
      };
      path = mkOption {
        type = types.str;
        default = cfg.cursor.name;
        description = "The path to the manifest";
      };
      name = mkOption {
        type = types.str;
        default = "rose-pine-hyprcursor";
        description = "The cursor theme to use. Must match one of the folders at the root of the package that is being used.";
      };
      size = mkOption {
        type = types.ints.positive;
        default = 24;
        description = "The size of the cursor.";
      };
    };
    xcursor = {
      package = mkOption {
        type = types.package;
        default = pkgs.rose-pine-cursor;
        description = "The package that contain directories with hyprcursor themes at '$out/share/icons'.";
      };
      name = mkOption {
        type = types.str;
        default = "rose-pine-cursor";
        description = "The cursor theme to use. Must match one of the folders at the root of the package that is being used.";
      };
      size = mkOption {
        type = types.ints.positive;
        default = 24;
        description = "The size of the cursor.";
      };
    };
  };
  config = mkIf cfg.enable (

    mkMerge [
      (mkIf (cfg.hypridle.enable) {
        services.hypridle = {
          enable = true;
          settings = import ./hypridle.nix;
        };
      })
      (mkIf (cfg.hyprlock.enable) {
        programs.hyprlock = {
          enable = true;
          settings = import ./hyprlock.nix {
            inherit cfg lib config wallpaper;
            colors = c;
          };
        };
      })
      {
        services.hyprpaper = {
          enable = true;
          settings = {
            ipc = "on";
            preload = ["${wallpaper}"];
            wallpaper = [
              ",${wallpaper}"
            ];
          };
        };
        home.packages = with pkgs;
          [
            swaybg
            wlsunset
            wl-clipboard
            cliphist
            hyprkool
            hyprpicker
            grimblast
            hypr-zoom
          ]
          ++ lib.optionals cfg.live_wallpaper.enable [
            zenity
            mpvpaper
            yt-dlp
          ];
        wayland.windowManager.hyprland = {
          enable = true;
          systemd.variables = ["--all"];
          xwayland.enable = true;
          plugins = with pkgs; [
            # hyprspace
            hyprkool
          ];
          settings = import ./hyprland.nix {
            inherit cfg lib config;
            colors = c;
          };
        };

        # xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
        # home.file."pictures/wallpaper.png".source = ./wallpaper.png;

        home.pointerCursor =
          cfg.xcursor
          // {
            gtk.enable = true;
            x11.enable = true;
          };

        xdg.configFile."hypr/hyprkool.toml".source = ./hyprkool.toml;
        home.file.".local/share/icons/${cfg.cursor.name}".source = "${cfg.cursor.package}/share/icons/${cfg.cursor.path}";
      }
    ]
  );
}
