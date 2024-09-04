{
  stdenv,
  fetchzip,
  cmake,
  hyprland,
  meson,
}:
stdenv.mkDerivation rec {
  pname = "hyprkool";
  version = "e0ae6c6b6513eaa70540fea200031743e4b62165";

  src = fetchzip {
    url = "https://github.com/thrombe/hyprkool/archive/refs/tags/0.7.1.tar.gz";
    hash = "sha256-II9j5IplV6tWg7AKsKIGkFSeDby+AJgB+nNHv3cU16k=";
  };

  nativeBuildInputs = [
    hyprland
  ];

  buildInputs = [
    cmake
    meson
  ];

  buildPhase = ''
    make plugin
    mv ./plugin/build/lib${pname}.so .
  '';
  installPhase = ''
    mkdir -p $out/lib
    mv ./lib${pname}.so $out/lib/lib${pname}.so
  '';

  dontUseCmakeConfigure = true;
  dontUseMesonConfigure = true;
}
