{colors}:
/*
css
*/
''
  @define-color theme_bg_color ${colors.background};

  * {
    border: 0px solid black;
  }

  .background {
    color: ${colors.text};
  }

  button {
    background-color: ${colors.gray02};
    background-image: none;
  }

  button.text-button {
    background-color: ${colors.gray02};
    background-image: none;
    font-weight: bold;
  }

  button.text-button:hover {
    background-color: ${colors.gray03};
  }

  button.default {
    color: ${colors.cyan};
  }

  button.destructive-action {
    color: ${colors.red};
  }

  combobox button.combo {
    background-color: ${colors.gray02};
    background-image: none;
  }

  combobox arrow {
    min-width: 16px;
    min-height: 16px;
    padding: 1.5px;
  }
''
