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

  .text-button {
    background-color: ${colors.gray02};
    background-image: none;
    font-weight: bold;
  }

  .text-button:hover {
    background-color: ${colors.gray03};
  }

  .default {
    color: ${colors.cyan};
  }

  .destructive-action {
    color: ${colors.red};
  }

  combobox {
    background-color: ${colors.gray02};
    background-image: none;
  }
''
