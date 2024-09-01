{
  user,
  config,
  lib,
  pkgs,
  ssh,
  fullName,
  ...
}: {
  environment.defaultPackages = [];
  services.xserver.desktopManager.xterm.enable = false;

  # Ensure fish is enabled for user even if the configuration is inactive
  programs.fish.enable = true;

  # User
  users.mutableUsers = false;

  # User
  users.users.${user} = {
    uid = 1000;
    isNormalUser = true;
    home = "/home/${user}";
    createHome = true;
    hashedPasswordFile = config.age.secrets.user-password.path;
    # Will be overwritten promptly after secrets has been
    # rekeyed with the new ssh key
    initialPassword = "root";
    description = fullName;
    extraGroups = ["wheel" "networkmanager"];
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
      config.common.default = "*";
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  nix = {
    settings.auto-optimise-store = true;
    settings.allowed-users = [user];
    settings.experimental-features = ["nix-command" "flakes"];
    settings.keep-outputs = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Boot settings
  boot.tmp.cleanOnBoot = true;

  # Set environment variables
  environment.variables = {
    EDITOR = "nvim";
    SHELL = "${pkgs.fish}/bin/fish";
    DIRENV_LOG_FORMAT = "";
    ANKI_WAYLAND = "1";
    OZ_ENABLE_WAYLAND = "1";
    DISABLE_QT5_COMPAT = "0";
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

  # System sound
  sound.enable = true;

  hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable bluetooth, enable pulseaudio, enable opengl (for Wayland)
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      hsphfpd.enable = true;
    };
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  # SSH
  services.openssh = {
    enable = true;
    ports = [22];
  };

  # Do not touch
  system.stateVersion = "23.11";
}
