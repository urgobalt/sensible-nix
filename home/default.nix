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

    # system
    ./wsl
    ./xdg
    ./gtk
    ./packages
    ./ssh
  ];
}
