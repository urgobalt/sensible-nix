{
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation rec {
  name = "vimix-hyprcursor";
  version = "97d6cff72a64c22f10680f68293f916a69edbed4";

  src = fetchFromGitHub {
    repo = "vimix-hyprcursor";
    owner = "BlackFuffey";
    rev = version;
    sha256 = "sha256-j7towY9u6AIoKqsq/X6BIssrfpY+lhAibBvIUcjc6dk=";
  };

  installPhase = ''
    mkdir -p $out/share/icons
    mkdir -p $out/src
    cp -r $src/* $out/src
    cp -r $src/themes/* $out/share/icons
  '';
}
