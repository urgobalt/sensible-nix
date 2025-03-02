{...}: {
  home.stateVersion = "23.11";
  imports = [
    # gui
    ./hyprland
    ./eww
    ./dunst
    ./waybar
    ./swaync

    # Applets
    ./fuzzel
    ./rofi
    ./kitty
    ./ghostty
    ./wezterm
    ./chromium
    ./zen
    ./social
    ./spacedrive

    # cli
    ./tmux
    ./nvim
    ./fish
    ./git
    ./pass
    ./direnv
    ./zoxide
    ./starship
    ./fastfetch

    # system
    ./wsl
    ./xdg
    ./gtk
    ./packages
    ./ssh
  ];
}
