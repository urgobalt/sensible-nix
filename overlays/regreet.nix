{
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  wrapGAppsHook4,
  glib,
  gtk4,
  pango,
  librsvg,
}:
rustPlatform.buildRustPackage rec {
  pname = "regreet";
  version = "9ff3e11bb1b66b52f6e44a9b6c0fe93a8c993f74";

  src = fetchFromGitHub {
    owner = "rharish101";
    repo = "ReGreet";
    rev = version;
    hash = "sha256-AjkB3Ob88igPXTpkQ3zc10mOc+aukriGOFIAh69NpcU=";
  };

  cargoHash = "sha256-N0+peYav2JhsEHTTVV5a4eOAMpdo9/gOGpduEofYr7w=";

  buildFeatures = ["gtk4_8"];

  nativeBuildInputs = [pkg-config wrapGAppsHook4];
  buildInputs = [glib gtk4 pango librsvg];

  meta.mainProgram = "regreet";
}
