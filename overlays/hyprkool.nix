{
  fetchFromGitHub,
  pkgs,
  libdrm,
  tomlplusplus,
  pixman,
  hyprland,
  hyprutils,
  wayland-protocols,
  wayland-utils,
  wayland,
  libxkbcommon,
  libinput,
  xwayland,
  xorg,
  libGL,
  hyprlang,
  hyprland-protocols,
  cairo,
  aquamarine,
  hyprgraphics,
}:
pkgs.unstable.rustPlatform.buildRustPackage rec {
  pname = "hyprkool";
  version = "51e3042205a6172acc55b7d4e95f0b3e71ba5e35";

  src = fetchFromGitHub {
    owner = "thrombe";
    repo = "hyprkool";
    rev = version;
    sha256 = "sha256-RdRXwmLdnJivbuP+c3P4tdF0DYjzpAJzG9wwqb3r3To=";
  };
  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    outputHashes = {
      "hyprland-0.4.0-alpha.3" = "sha256-dUJOOQeh1iBC3W2DWmaHdbs9DnufeZzMOdrrhPFHf70=";
    };
  };
  buildInputs = [
    libdrm
    tomlplusplus
    pixman
    hyprland
    hyprutils
    wayland-protocols
    hyprgraphics.dev
    wayland-utils
    wayland
    libinput
    libxkbcommon
    libGL
    hyprlang
    hyprland-protocols
    cairo
    aquamarine
    # xorg.libXcursor
    # xorg.libxcb
    # xorg.libXdmcp
    # xorg.xcbutilerrors
    # xorg.xcbutilrenderutil
    # xorg.xcbutilwm
    # xwayland
  ];
  nativeBuildInputs = with pkgs; [
    pkg-config
    cmake
  ];
  dontUseMesonConfigure = true;
  dontUseCmakeConfigure = true;
  buildPhase = ''
    cargo build --release
    make plugin
    mv ./plugin/build/lib${pname}.so .
  '';
  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/bin
    mv ./lib${pname}.so $out/lib/lib${pname}.so
    mv ./target/release/${pname} $out/bin/${pname}
  '';
}
