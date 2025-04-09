{
  user,
  config,
  lib,
  pkgs,
  ssh,
  full-name,
  ...
}: {
  environment.defaultPackages = [];
  environment.systemPackages = with pkgs; [openssl];
  services.xserver.desktopManager.xterm.enable = false;

  # Ensure fish is enabled for user even if the configuration is inactive
  programs.fish.enable = true;

  services.fwupd = {enable = true;};
  # User
  users.users.${user} = {
    uid = 1000;
    isNormalUser = true;
    home = "/home/${user}";
    createHome = true;
    description = full-name;
    extraGroups = ["audio" "wheel" "networkmanager"];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = ssh.users;
  };

  users.users.root.openssh.authorizedKeys.keys = ssh.users;

  # Locale settings
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = ["en_US.UTF-8/UTF-8"];
    extraLocaleSettings = {
      LANGUAGE = "en_US.UTF-8";
      LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    };
  };

  # Set up a font for the tty
  console = {
    font = "Lat2-Terminus16";
    keyMap = "sv-latin1";
  };

  # Set a timezone
  time.timeZone = lib.mkDefault "Europe/Stockholm";

  # Font settings
  fonts = {
    packages = with pkgs; [
      # Add all fonts to be installed here
      (nerdfonts.override {fonts = ["SourceCodePro"];})
    ];

    fontconfig.defaultFonts = {
      serif = [
        "SourceCodePro Nerd Font"
      ];
      sansSerif = [
        "SauceCodePro Nerd Font"
      ];
      monospace = [
        "SauceCodePro Nerd Font"
      ];
    };
  };

  # Wayland stuff: enable XDG integration, allow sway to use brillo
  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [xdg-desktop-portal-gtk];
    };
  };

  nix = {
    settings.auto-optimise-store = true;
    settings.allowed-users = [user];
    settings.experimental-features = ["nix-command" "flakes"];
    settings.keep-outputs = false;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    extraOptions = ''
      !include ${config.age.secrets.nix-access-tokens.path}
    '';
  };

  # Boot settings
  boot.tmp.cleanOnBoot = true;

  # Allow mounting ntfs drives
  boot.supportedFilesystems = ["ntfs"];

  # Set environment variables
  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    SHELL = lib.getExe pkgs.fish;
    DIRENV_LOG_FORMAT = "";
    ANKI_WAYLAND = "1";
    OZ_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    DISABLE_QT5_COMPAT = "0";
    NIXOS_OZONE_WL = "1";
  };

  # Security
  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = true;
      extraConfig = ''
        Defaults env_keep += "EDITOR"
        Defaults env_keep += "XDG_CONFIG_HOME"
        Defaults env_keep += "SSH_HOME"
        Defaults env_keep += "XDG_RUNTIME_DIR"

        Defaults insults
      '';
    };

    protectKernelImage = true;
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
    "monitor.bluez.properties" = {
      "bluez5.enable-sbc-xq" = true;
      "bluez5.enable-msbc" = true;
      "bluez5.enable-hw-volume" = true;
      "bluez5.hfphsp-backend" = "native";
      "bluez5.roles" = ["hfp_ag" "hfp_hf" "a2dp_sink" "a2dp_source" "bap_sink" "bap_source"];
    };
  };
  # Enable bluetooth, enable pulseaudio, enable opengl (for Wayland)
  hardware = {
    keyboard.qmk.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      hsphfpd.enable = false;
      settings = {
        General = {
          MultiProfile = "multiple";
          FastConnectable = true;
          ReconnectAttempts = 0;
          ReconnectIntervals = "1, 2, 3";
          ReverseServiceDiscovery = true;
        };
      };
    };
    graphics = lib.mkMerge [
      {
        enable = true;
        extraPackages = with pkgs; [
          vaapiVdpau
          libvdpau-va-gl
        ];
      }
      (lib.mkIf pkgs.stdenv.isx86_64 {
        extraPackages = with pkgs; [intel-media-driver];
      })
    ];
    enableAllFirmware = true;
  };

  powerManagement.powertop.enable = true;

  # SSH
  services.openssh = {
    enable = true;
    ports = [22];
    settings.PasswordAuthentication = false;
  };

  # Do not touch
  system.stateVersion = "23.11";
}
