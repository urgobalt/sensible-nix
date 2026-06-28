{config, ...}: {
  assertions = [
    {
      assertion = config.home-manager.users.test.wayland.windowManager.hyprland.enable;
      message = "Hyprland should be enabled.";
    }
  ];
  sensible.hyprland.enable = true;
}
