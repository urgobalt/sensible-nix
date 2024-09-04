{
  stdenv,
  fetchzip,
}:
stdenv.mkDerivaton {
  pname = "hyprkool";
  version = "e0ae6c6b6513eaa70540fea200031743e4b62165";

  src = fetchzip {
    url = "https://github.com/thrombe/hyprkool/archive/refs/tags/0.7.1.tar.gz";
    hash = "";
  };
}
