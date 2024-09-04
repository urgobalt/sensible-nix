{
  lib,
  gcc13Stdenv,
  stdenv,
  fetchFromGitHub,
  symlinkJoin,
  pkgs,
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
}: let
  meta = {
    name = "hyprkool";
    version = "3f56d829b44218d70867886b91d9f697d8ad9f68";
    githubHash = "sha256-LYtAvRlE1zJCYmnY1EYroGu5zGlIMMr9bFIBLM7hwng=";
  };
  binary = pkgs.unstable.rustPlatform.buildRustPackage rec {
    pname = "${meta.name}-bin";
    version = meta.version;

    src = fetchFromGitHub {
      owner = "thrombe";
      repo = "hyprkool";
      rev = meta.version;
      sha256 = "sha256-HHmJey9l4+BW+5PYMLfeqcHwtIZcJ8ZI42ARgRRNC+E=";
    };
    cargoLock = {
      lockFile = "${src}/Cargo.lock";
      outputHashes = {
        "hyprland-0.4.0-alpha.2" = "sha256-7GRj0vxsQ4ORp0hSBAorjFYvWDy+edGU2IL3DhFDLvQ=";
      };
    };
    nativeBuildInputs = [
      pkg-config
    ];
  };
  plugin = gcc13Stdenv.mkDerivation rec {
    pname = "${meta.name}-plugin";
    version = "3f56d829b44218d70867886b91d9f697d8ad9f68";

    src = fetchFromGitHub {
      owner = "thrombe";
      repo = "hyprkool";
      rev = version;
      sha256 = meta.githubHash;
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
      mv ./plugin/build/lib${meta.name}.so .
    '';
    installPhase = ''
      mkdir -p $out/lib
      mv ./lib${meta.name}.so $out/lib/lib${meta.name}.so
    '';
  };
in
  symlinkJoin {
    name = "hyprkool";
    path = [binary plugin];
  }
