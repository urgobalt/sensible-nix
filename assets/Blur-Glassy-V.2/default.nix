{
  stdenvNoCC,
  pkgs,
  name
}:

let
  KdeInput=with pkgs.kdePackages;[
    plasma-workspace
    ];
  buildInput=with pkgs.libsForQt5;[
    qt5.qtgraphicaleffects
    plasma-workspace
    plasma-framework
    kconfig

  ]++KdeInput;

in
  stdenvNoCC.mkDerivation {
  name = "sddm-theme";
  src = ./.;

  propegatedBuildInputs = buildInput;

  dontWrapQtApps = true;

  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -r $src $out/share/sddm/themes/${name}

    mkdir -p $out/nix-support
    '';

  postFixup = with pkgs.libsForQt5;''
    export support=$out/nix-support/propagated-user-env-packages
    echo ${qt5.qtgraphicaleffects} >> $support
    echo ${plasma-workspace}>> $support
    echo ${plasma-framework}>>$support
    echo ${kconfig}>>$support
    '';
}
