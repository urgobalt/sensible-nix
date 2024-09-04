{
  lib,
  gcc13Stdenv,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  cmake,
  ninja,
  cairo,
  expat,
  fribidi,
  git,
  hwdata,
  hyprcursor,
  hyprlang,
  hyprutils,
  libGL,
  libdatrie,
  libdisplay-info,
  libdrm,
  libexecinfo,
  libinput,
  libliftoff,
  libselinux,
  libsepol,
  libthai,
  libuuid,
  libxkbcommon,
  mesa,
  pango,
  pciutils,
  pcre2,
  seatd,
  systemd,
  tomlplusplus,
  wayland,
  wayland-protocols,
  xorg,
  xwayland,
  meson,
  hyprland,
  enableXWayland ? true,
  withSystemd ? lib.meta.availableOn stdenv.hostPlatform systemd,
}:
gcc13Stdenv.mkDerivation rec {
  pname = "Hyprkool";
  version = "e0ae6c6b6513eaa70540fea200031743e4b62165";

  src = fetchFromGitHub {
    owner = "thrombe";
    repo = "hyprkool";
    rev = version;
    sha256 = "sha256-LYtAvRlE1zJCYmnY1EYroGu5zGlIMMr9bFIBLM7hwng=";
  };

  nativeBuildInputs = [
    pkg-config
    hyprland
  ];

  buildInputs = lib.concatLists [
    [
      cairo
      expat
      fribidi
      git
      hwdata
      hyprcursor
      hyprlang
      hyprutils
      libdatrie
      libdisplay-info
      libdrm
      libGL
      libinput
      libliftoff
      libselinux
      libsepol
      libthai
      libuuid
      libxkbcommon
      mesa
      pango
      pciutils
      pcre2
      seatd
      tomlplusplus
      wayland
      wayland-protocols
      xorg.libXcursor
      ninja
      cmake
      meson
    ]
    (lib.optionals stdenv.hostPlatform.isMusl [libexecinfo])
    (lib.optionals enableXWayland [
      xorg.libxcb
      xorg.libXdmcp
      xorg.xcbutil
      xorg.xcbutilerrors
      xorg.xcbutilrenderutil
      xorg.xcbutilwm
      xwayland
    ])
    (lib.optionals withSystemd [systemd])
  ];
  dontUseMesonConfigure = true;
  dontUseCmakeConfigure = true;
  buildPhase = ''
    make plugin
    mv ./plugin/build/lib${pname}.so .
  '';
  installPhase = ''
    mkdir -p $out/lib
    mv ./lib${pname}.so $out/lib/lib${pname}.so
  '';
}
