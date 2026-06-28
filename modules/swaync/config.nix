{ config, lib }: 
let
  focusScript = if config.sensible.hyprland.enable then ''
    hyprctl dispatch focuswindow "$SWAYNC_APP_NAME"
  '' else if config.sensible.niri.enable then ''
    niri msg action focus-window --app-id "$SWAYNC_APP_NAME"
  '' else lib.warn "No window manager for swaync";
in
builtins.toJSON {
  "positionX" = "right";
  "positionY" = "top";
  "layer" = "overlay";
  "control-center-layer" = "top";
  "layer-shell" = true;
  "cssPriority" = "application";
  "control-center-margin-top" = 10;
  "control-center-margin-bottom" = 10;
  "control-center-margin-right" = 10;
  "control-center-margin-left" = 0;
  "notification-2fa-action" = true;
  "notification-inline-replies" = false;
  "notification-icon-size" = 64;
  "notification-body-image-height" = 100;
  "notification-body-image-width" = 200;
  "timeout" = 10;
  "timeout-low" = 5;
  "timeout-critical" = 0;
  "fit-to-screen" = true;
  "relative-timestamps" = true;
  "control-center-width" = 400;
  "control-center-height" = 600;
  "notification-window-width" = 500;
  "keyboard-shortcuts" = true;
  "image-visibility" = "when-available";
  "transition-time" = 100;
  "hide-on-clear" = true;
  "hide-on-action" = true;
  "text-empty" = "No Notifications";
  "script-fail-notify" = true;
  "scripts" = lib.optionalAttrs (focusScript != "") {
    "wm-focus" = {
      exec = focusScript;
      urgency = "Normal";
      run-on = "action";
    };
  };
  "notification-visibility" = {
    "Music" = {
      "state" = "muted";
      "urgency" = "Low";
      "app-name" = "Spotify";
    };
    "Music Premium" = {
      "state" = "muted";
      "urgency" = "Low";
      "app-name" = "Spotify Premium";
    };
  };
  "widgets" = [
    "title"
    "mpris"
    "dnd"
    "notifications"
  ];
  "widget-config" = {
    "inhibitors" = {
      "text" = "Inhibitors";
      "button-text" = "Clear All";
      "clear-all-button" = true;
    };
    "title" = {
      "text" = "Notifications";
      "clear-all-button" = true;
      "button-text" = "Clear All";
    };
    "dnd" = {
      "text" = "Do Not Disturb";
    };
    "label" = {
      "max-lines" = 5;
      "text" = "Label Text";
    };
    "mpris" = {
      "image-size" = 96;
      "image-radius" = 12;
      "blacklist" = [];
    };
    "buttons-grid" = {
      "actions" = [
        {
          "label" = "直";
          "type" = "toggle";
          "active" = true;
          "command" = "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && nmcli radio wifi on || nmcli radio wifi off'";
          "update-command" = "sh -c '[[ $(nmcli radio wifi) == \"enabled\" ]] && echo true || echo false'";
        }
      ];
    };
  };
}
