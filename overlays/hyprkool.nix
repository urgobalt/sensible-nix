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
}:
pkgs.unstable.rustPlatform.buildRustPackage rec {
  pname = "hyprkool";
  version = "1263ad8800213b7ac5088a1a1ad3b309ddd0bd92";

  src = fetchFromGitHub {
    owner = "thrombe";
    repo = "hyprkool";
    rev = version;
    sha256 = "sha256-S14EGhrnHVz00KdEyIYPiBYrFxsmOyaDwU19+QDXR9M=";
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
