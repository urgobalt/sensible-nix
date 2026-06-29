{config}: let
  c = config.lib.stylix.colors;
  border-radius = "5px";
  margin = "10px";
in
  ''
    @define-color cc-bg rgba(26, 26, 25, 0.5);
    @define-color noti-border-color rgba(255, 255, 255, 0.05);
    @define-color noti-bg ${c.base00};
    @define-color noti-bg-opaque ${c.base01};
    @define-color noti-bg-darker ${c.base02};
    @define-color noti-bg-hover ${c.base03};
    @define-color noti-bg-hover-opaque ${c.base03};
    @define-color noti-bg-focus rgba(51, 51, 50, 0.8);
    @define-color noti-close-bg rgba(255, 255, 255, 0.1);
    @define-color noti-close-bg-hover rgba(255, 255, 255, 0.15);
    @define-color text-color ${c.base05};
    @define-color text-color-disabled rgb(150, 150, 150);
    @define-color bg-selected rgb(0, 128, 255);

    .notification-row { outline: none; }

    .notification-row:focus, .notification-row:hover { background: @noti-bg-focus; }

    .notification-row .notification-background { padding: 6px 12px; }

    .notification-row .notification-background .close-button {
      background: @noti-close-bg;
      color: @text-color;
      text-shadow: none;
      padding: 0;
      border-radius: 100%;
      margin-top: 5px;
      margin-right: 5px;
      box-shadow: none;
      border: none;
      min-width: 24px;
      min-height: 24px;
    }

    .notification-row .notification-background .close-button:hover {
      box-shadow: none;
      background: @noti-close-bg-hover;
      transition: background 0.15s ease-in-out;
      border: none;
    }

    .notification-row .notification-background .notification {
      border-radius: ${border-radius};
      border: 2px solid @noti-border-color;
      padding: 0;
      transition: background 0.15s ease-in-out;
      background: @noti-bg;
    }

    .notification-row .notification-background .notification .notification-action, .notification-row .notification-background .notification .notification-default-action {
      padding: 4px;
      margin: 0;
      box-shadow: none;
      background: transparent;
      border: none;
      color: @text-color;
      transition: background 0.15s ease-in-out;
    }

    .notification-row .notification-background .notification .notification-action:hover, .notification-row .notification-background .notification .notification-default-action:hover {
      -gtk-icon-effect: none;
      background: @noti-bg-hover;
    }

    .notification-row .notification-background .notification .notification-default-action { border-radius: ${border-radius}; }

    .notification-row .notification-background .notification .notification-default-action:not(:only-child) {
      border-bottom-left-radius: 0px;
      border-bottom-right-radius: 0px;
    }

    .notification-row .notification-background .notification .notification-default-action .notification-content {
      background: transparent;
      border-radius: ${border-radius};
      padding: 4px;
    }

    .notification-row .notification-background .notification .notification-default-action .notification-content .image {
      -gtk-icon-effect: none;
      border-radius: ${border-radius};
      margin: 4px;
    }

    .notification-row .notification-background .notification .notification-default-action .notification-content .app-icon {
      -gtk-icon-effect: none;
      -gtk-icon-shadow: 0 1px 4px black;
      margin: 6px;
    }

    .notification-row .notification-background .notification .notification-default-action .notification-content .text-box .summary {
      font-size: 16px;
      font-weight: bold;
      background: transparent;
      color: @text-color;
      text-shadow: none;
    }

    .notification-row .notification-background .notification .notification-default-action .notification-content .text-box .time {
      font-size: 16px;
      font-weight: bold;
      background: transparent;
      color: @text-color;
      text-shadow: none;
      margin-right: 30px;
    }

    .notification-row .notification-background .notification .notification-default-action .notification-content .text-box .body {
      font-size: 15px;
      font-weight: normal;
      background: transparent;
      color: @text-color;
      text-shadow: none;
    }

    .notification-row .notification-background .notification .notification-default-action .notification-content progressbar { margin-top: 4px; }

    .notification-row .notification-background .notification .notification-default-action .notification-content .body-image {
      margin-top: 4px;
      background-color: white;
      border-radius: ${border-radius};
      -gtk-icon-effect: none;
    }

    .notification-row .notification-background .notification .notification-default-action .notification-content .inline-reply { margin-top: 4px; }

    .notification-row .notification-background .notification .notification-default-action .notification-content .inline-reply .inline-reply-entry {
      background: @noti-bg-darker;
      color: @text-color;
      caret-color: @text-color;
      border: 2px solid @noti-border-color;
      border-radius: ${border-radius};
    }

    .notification-row .notification-background .notification .notification-default-action .notification-content .inline-reply .inline-reply-button {
      margin-left: 4px;
      background: @noti-bg;
      border: 1px solid @noti-border-color;
      border-radius: ${border-radius};
      color: @text-color;
    }

    .notification-row .notification-background .notification .notification-default-action .notification-content .inline-reply .inline-reply-button:disabled {
      background: initial;
      color: @text-color-disabled;
      border: 2px solid @noti-border-color;
      border-color: transparent;
    }

    .notification-row .notification-background .notification .notification-default-action .notification-content .inline-reply .inline-reply-button:hover { background: @noti-bg-hover; }

    .notification-row .notification-background .notification .notification-action {
      border-top: 1px solid @noti-border-color;
      border-radius: 0px;
      border-right: 1px solid @noti-border-color;
    }

    .notification-row .notification-background .notification .notification-action:first-child { border-bottom-left-radius: 12px; }

    .notification-row .notification-background .notification .notification-action:last-child {
      border-bottom-right-radius: 12px;
      border-right: none;
    }

    .notification-group.collapsed .notification-row .notification { background-color: @noti-bg-opaque; }

    .notification-group.collapsed:hover .notification-row:not(:only-child) .notification { background-color: @noti-bg-hover-opaque; }

    .control-center {
      background: @cc-bg;
      color: @text-color;
      border-radius: ${border-radius};
      border: 2px solid @noti-border-color;
    }

    .control-center .control-center-list-placeholder { opacity: 0.2; }

    .control-center .control-center-list { background: transparent; }

    .control-center .control-center-list .notification { box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.3), 0 1px 3px 1px rgba(0, 0, 0, 0.7), 0 2px 6px 2px rgba(0, 0, 0, 0.3); }

    .control-center .control-center-list .notification .notification-default-action,
    .control-center .control-center-list .notification .notification-action { transition: opacity 400ms ease-in-out, background 0.15s ease-in-out; }

    .control-center .control-center-list .notification .notification-default-action:hover,
    .control-center .control-center-list .notification .notification-action:hover { background-color: @noti-bg-hover; }

    .blank-window { background: transparent; }

    .floating-notifications { background: transparent; }

    .floating-notifications .notification { box-shadow: none; }

    .widget-title { color: @text-color; margin: 8px; font-size: 1.5rem; }

    .widget-title > button {
      font-size: initial;
      color: @text-color;
      text-shadow: none;
      background: @noti-bg;
      border: 2px solid @noti-border-color;
      box-shadow: none;
      border-radius: ${border-radius};
    }

    .widget-title > button:hover { background: @noti-bg-hover; }

    .widget-dnd { color: @text-color; margin: 8px; font-size: 1.1rem; }

    .widget-dnd > switch {
      font-size: initial;
      border-radius: ${border-radius};
      background: @noti-bg;
      border: 1px solid @noti-border-color;
      box-shadow: none;
    }

    .widget-dnd > switch:checked { background: @bg-selected; }

    .widget-dnd > switch slider { background: @noti-bg-hover; border-radius: ${border-radius}; }

    .widget-label { margin: 8px; }

    .widget-label > label { font-size: 1.1rem; }

    @define-color mpris-album-art-overlay rgba(0, 0, 0, 0.55);
    @define-color mpris-button-hover rgba(0, 0, 0, 0.50);

    .widget-mpris .widget-mpris-player {
      padding: 8px;
      padding: 16px;
      margin: 16px 20px;
      background-color: @mpris-album-art-overlay;
      border-radius: ${border-radius};
      box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.75);
    }

    .widget-mpris .widget-mpris-player button:hover { background: @noti-bg-hover; }

    .widget-mpris .widget-mpris-player .widget-mpris-album-art {
      border-radius: ${border-radius};
      box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.75);
    }

    .widget-mpris .widget-mpris-player .widget-mpris-title { font-weight: bold; font-size: 1.25rem; }

    .widget-mpris .widget-mpris-player .widget-mpris-subtitle { font-size: 1.1rem; }

    .widget-mpris .widget-mpris-player > box > button:hover { background-color: @mpris-button-hover; }

    .widget-buttons-grid { padding: 8px; margin: 8px; border-radius: ${border-radius}; background-color: @noti-bg; }

    .widget-buttons-grid > flowbox > flowboxchild > button { background: @noti-bg; border-radius: ${border-radius}; }

    .widget-menubar > box > .menu-button-bar > button { border: none; background: transparent; }

    .topbar-buttons > button { border: none; background: transparent; }

    .widget-volume { background-color: @noti-bg; padding: 8px; margin: 8px; border-radius: ${border-radius}; }

    .widget-volume > box > button { background: transparent; border: none; }

    .per-app-volume { background-color: @noti-bg-alt; padding: 4px 8px 8px 8px; margin: 0px 8px 8px 8px; border-radius: ${border-radius}; }

    .widget-backlight { background-color: @noti-bg; padding: 8px; margin: 8px; border-radius: ${border-radius}; }

    .widget-inhibitors { margin: 8px; font-size: 1.5rem; }

    .widget-inhibitors > button {
      font-size: initial;
      color: @text-color;
      text-shadow: none;
      background: @noti-bg;
      border: 1px solid @noti-border-color;
      box-shadow: none;
      border-radius: ${border-radius};
    }

    .widget-inhibitors > button:hover { background: @noti-bg-hover; }
  ''
