{
  stdenvNoCC,
  pkgs,
  name,
}: let
  propegatedBuildInputs = with pkgs.libsForQt5; [
    qt5.qtgraphicaleffects
    plasma-workspace
    plasma-framework
    kconfig
  ];
in
  stdenvNoCC.mkDerivation {
    name = "sddm-theme";
    src = ./.;

    propegatedBuildInputs = propegatedBuildInputs;

    dontWrapQtApps = true;

    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -r $src $out/share/sddm/themes/${name}

      mkdir -p $out/nix-support
    '';

    postFixup = with pkgs.libsForQt5; ''
      echo ${qt5.qtgraphicaleffects} >> $out/nix-support/propagated-user-env-packages
      echo ${plasma-workspace} >> $out/nix-support/propagated-user-env-packages
      echo ${plasma-framework} >> $out/nix-support/propagated-user-env-packages
      echo ${kconfig} >> $out/nix-support/propagated-user-env-packages
    '';
  }
