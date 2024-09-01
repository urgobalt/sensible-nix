{
  pkgs,
  fullName,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.neomutt;
  getPassword = path: "${pkgs.uutils-coreutils-noprefix}/bin/head -zn 1 ${path}";
in {
  options.modules.neomutt = {enable = mkEnableOption "neomutt";};
  config = mkIf cfg.enable {
    accounts.email = {
      maildirBasePath = "mail";
      accounts = {
        "personal" = {
          flavor = "gmail.com";
          realName = fullName;
          address = "lukecastellan165@gmail.com";
          passwordCommand = getPassword config.age.secrets.personal-email.path;
          neomutt = {
            enable = true;
          };
        };
        "professional" = {
          primary = true;
          flavor = "gmail.com";
          realName = fullName;
          address = "ludvigkallqvistnygren@gmail.com";
          passwordCommand = getPassword config.age.secrets.professional-email.path;
          neomutt = {
            enable = true;
          };
        };
        # "nygren" = {
        #   flavor = "plain";
        #   realName = fullName;
        #   address = "ludvig@nygren.nu";
        #   passwordCommand = getPassword config.age.secrets.nygren-email.path;
        #   neomutt = {
        #     enable = true;
        #   };
        # };
      };
    };

    programs.neomutt = {
      enable = true;
      vimKeys = true;
      unmailboxes = true;
      # settings = {
      # }
      # // import ./settings.nix
      # // import ./colors.nix
      # // import ./keymaps.nix;
    };
  };
}
