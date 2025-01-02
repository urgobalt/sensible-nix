{
  fetchFromGitHub,
  lib,
  stdenv,
  bzip2,
  expat,
  fontconfig,
  freetype,
  harfbuzz,
  libpng,
  oniguruma,
  zlib,
  libGL,
  libX11,
  libXcursor,
  libXi,
  libXrandr,
  glib,
  gtk4,
  libadwaita,
  wrapGAppsHook4,
  gsettings-desktop-schemas,
  git,
  ncurses,
  pkg-config,
  zig_0_13,
  pandoc,
  revision ? "dirty",
  optimize ? "Debug",
  x11 ? false,
}: let
  # The Zig hook has no way to select the release type without actual
  # overriding of the default flags.
  #
  # TODO: Once
  # https://github.com/ziglang/zig/issues/14281#issuecomment-1624220653 is
  # ultimately acted on and has made its way to a nixpkgs implementation, this
  # can probably be removed in favor of that.
  zig_hook = zig_0_13.hook.overrideAttrs {
    zig_default_flags = "-Dcpu=baseline -Doptimize=${optimize}";
  };
in
  stdenv.mkDerivation rec {
    pname = "ghostty";
    version = "v1.0.0";
    src = fetchFromGitHub {
      owner = "ghostty-org";
      repo = "ghostty";
      rev = version;
      sha256 = "sha256-AHI1Z4mfgXkNwQA8xYq4tS0/BARbHL7gQUT41vCxQTM=";
    };

    nativeBuildInputs = [
      git
      ncurses
      pandoc
      pkg-config
      zig_hook
      wrapGAppsHook4
    ];

    buildInputs =
      [
        libGL
      ]
      ++ lib.optionals stdenv.hostPlatform.isLinux [
        bzip2
        expat
        fontconfig
        freetype
        harfbuzz
        libpng
        oniguruma
        zlib

        libadwaita
        gtk4
        glib
        gsettings-desktop-schemas
      ]
      ++ lib.optionals x11 [
        libX11
        libXcursor
        libXi
        libXrandr
      ];

    dontConfigure = true;

    zigBuildFlags = "-Dversion-string=${version}-${revision}-nix";

    outputs = [
      "out"
      "terminfo"
      "shell_integration"
      "vim"
    ];

    postInstall = ''
      terminfo_src=${
        if stdenv.hostPlatform.isDarwin
        then ''"$out/Applications/Ghostty.app/Contents/Resources/terminfo"''
        else "$out/share/terminfo"
      }

      mkdir -p "$out/nix-support"

      mkdir -p "$terminfo/share"
      mv "$terminfo_src" "$terminfo/share/terminfo"
      ln -sf "$terminfo/share/terminfo" "$terminfo_src"
      echo "$terminfo" >> "$out/nix-support/propagated-user-env-packages"

      mkdir -p "$shell_integration"
      mv "$out/share/ghostty/shell-integration" "$shell_integration/shell-integration"
      ln -sf "$shell_integration/shell-integration" "$out/share/ghostty/shell-integration"
      echo "$shell_integration" >> "$out/nix-support/propagated-user-env-packages"

      mv $out/share/vim/vimfiles "$vim"
      ln -sf "$vim" "$out/share/vim/vimfiles"
      echo "$vim" >> "$out/nix-support/propagated-user-env-packages"
    '';

    postFixup = lib.optionalString x11 ''
      patchelf --add-rpath "${lib.makeLibraryPath [libX11]}" "$out/bin/.ghostty-wrapped"
    '';

    meta = {
      homepage = "https://github.com/ghostty-org/ghostty";
      license = lib.licenses.mit;
      platforms = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      mainProgram = "ghostty";
    };
  }
