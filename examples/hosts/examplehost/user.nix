{...}: {
  config.modules = {
    # gui
    hyprland.enable = true;
    eww.enable = true;
    waybar.enable = false;
    dunst.enable = false;

    # applets
    kitty.enable = true;
    fuzzel.enable = true;
    chromium.enable = true;
    social.enable = true;

    # cli
    nvim.enable = true;
    fish.enable = true;
    git.enable = true;
    pass.enable = true;
    tmux.enable = true;

    # system
    xdg.enable = true;
    gtk.enable = true;
    packages.enable = true;
  };
}

