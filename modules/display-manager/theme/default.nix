{
  stdenvNoCC,
  pkgs,
  path,
}:
stdenvNoCC.mkDerivation {
  name = "sddm-theme";
  src = path;

  propegatedBuildInputs = [
    pkgs.libsForQt5.qt5.qtgraphicaleffects
  ];

  dontWrapQtApps = true;

  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -r $src $out/share/sddm/themes/current
  '';

  postFixup = ''
    mkdir -p $out/nix-support

    echo ${pkgs.libsForQt5.qt5.qtgraphicaleffects} >> $out/nix-support/propagated-user-env-packages
  '';
}
