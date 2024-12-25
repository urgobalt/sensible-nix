{
  pkgs,
  lib,
  config,
  agenix,
  ...
}:
with lib; let
  cfg = config.modules.packages;
in {
  options.modules.packages = {enable = mkEnableOption "packages";};

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Encryption management
      agenix.packages.x86_64-linux.default
      # System
      eza
      trashy
      bat
      unixtools.xxd
      inotify-tools
      fd
      mlocate
      bluetui
      bluetuith
      brightnessctl
      pamixer

      gcc
      gnumake
      xdg-utils

      wget

      # System management packages
      vim
      tldr
      just

      btop

      # Source control
      gh

      # Utils
      speedtest-rs
      ripgrep

      # Databases
      sqlite

      # Hacking the brain
      toipe
      obsidian

      # Spellchecking
      aspell
      aspellDicts.sv
      aspellDicts.en
      aspellDicts.en-computers
      aspellDicts.en-science

      firefox
    ];
  };
}
