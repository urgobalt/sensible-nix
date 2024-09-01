{
  stdenvNoCC,
  pkgs,
}:
stdenvNoCC.mkDerivation {
  name = "sddm-sugar-dark";
  src = ./.;

  propegatedBuildInputs = [
    pkgs.libsForQt5.qt5.qtgraphicaleffects
  ];

  dontWrapQtApps = true;

  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -r $src $out/share/sddm/themes/sugar-dark
  '';

  postFixup = ''
    mkdir -p $out/nix-support

    echo ${pkgs.libsForQt5.qt5.qtgraphicaleffects} >> $out/nix-support/propagated-user-env-packages
  '';
}
