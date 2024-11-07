{ stdenvNoCC
, fetchFromGitHub
, libsForQt5
}:

stdenvNoCC.mkDerivation rec {
  pname = "sddm-rose-pine-theme";
  version = "1.0";
  dontBuild = true;

  propagatedUserEnvPkgs = [
    libsForQt5.qt5.qtgraphicaleffects
  ];

  src = fetchFromGitHub {
    owner = "MaraWoerle";
    repo = "sddm-rose-pine";
    rev = "v${version}";
    sha256 = "sha256-Deoaf5EXFD+qD80duw0t2bpujeKXo1zl9uNfRx/e4XA=";
  };

  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -aR $src $out/share/sddm/themes/rose-pine
  '';

  postInstall = ''
  '';
}
