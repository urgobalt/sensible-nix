{...}: {
  home.stateVersion = "23.11";
  imports = [
    # gui
    ./hyprland
    ./eww
    ./dunst
    ./waybar

    # Applets
    ./fuzzel
    ./rofi
    ./kitty
    ./wezterm
    ./chromium
    ./social

    # cli
    ./tmux
    ./nvim
    ./fish
    ./git
    ./pass
    ./direnv

    # system
    ./wsl
    ./xdg
    ./gtk
    ./packages
  ];
}
