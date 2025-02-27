{
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "hypr-zoom";
  version = "v0.0.3";

  src = fetchFromGitHub {
    owner = "FShou";
    repo = pname;
    rev = version;
    sha256 = "sha256-/5nC4iLcDJ+UODLpzuVitQTFdBZtz75ep73RSN37hHE=";
  };

  vendorHash = "sha256-BCx2hKi6U/MPJlwAmnM4/stiolhYkakpe4EN3e5r6L4=";

  meta = {
    description = "Smoothly Animated Zoom for Hyprland";
    homepage = "https://github.com/FShou/hypr-zoom";
    mainProgram = pname;
  };
}
