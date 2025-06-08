{
  lib,
  gcc13Stdenv,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  makeWrapper,
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
  hyprwayland-scanner,
  jq,
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
  python3,
  seatd,
  systemd,
  tomlplusplus,
  wayland,
  wayland-protocols,
  wayland-scanner,
  xorg,
  xwayland,
  meson,
  hyprland,
  enableXWayland ? true,
  withSystemd ? lib.meta.availableOn stdenv.hostPlatform systemd,
}:
gcc13Stdenv.mkDerivation rec {
  pname = "Hyprspace";
  version = "edad6cf735097b7cb4406d3fc8daddd09dfa458a";

  src = fetchFromGitHub {
    owner = "KZDKM";
    repo = "Hyprspace";
    rev = version;
    sha256 = "sha256-LYtAvRlE1zJCYmnY1EYroGu5zGlIMMr9bFIBLM7hwng=";
  };

  nativeBuildInputs = [
    hyprwayland-scanner
    jq
    makeWrapper
    cmake
    ninja
    pkg-config
    python3 # for udis86
    wayland-scanner
    meson
  ];

  buildInputs = lib.concatLists [
    [
      hyprland
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

  dontUseCmakeConfigure = true;
}
