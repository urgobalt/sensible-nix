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
  hyprgraphics,
  enableXWayland ? true,
  withSystemd ? lib.meta.availableOn stdenv.hostPlatform systemd,
}:
gcc13Stdenv.mkDerivation rec {
  pname = "hyprkool";
  version = "e0ae6c6b6513eaa70540fea200031743e4b62165";

  src = fetchFromGitHub {
    owner = "thrombe";
    repo = "hyprkool";
    rev = version;
    sha256 = "sha256-HHmJey9l4+BW+5PYMLfeqcHwtIZcJ8ZI42ARgRRNC+E=";
  };

  nativeBuildInputs = [
    pkg-config
    hyprland
    hyprgraphics
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
      hyprgraphics.dev
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
