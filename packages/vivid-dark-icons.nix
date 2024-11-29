{ stdenvNoCC
, fetchFromGitHub
, gtk3
}:

stdenvNoCC.mkDerivation rec {
  pname = "Vivid-Dark-Icons";
  version = "1.0";
  dontBuild = true;

  nativeBuildInputs = [ gtk3 ];

  src = fetchFromGitHub {
    owner = "MaraWoerle";
    repo = "Vivid-Plasma-Themes";
    rev = "v${version}";
    sha256 = "sha256-BAGsOV7N0r1Vwudmgw3hK1rQ4zzCEhLkhA5Kr4LLTtI=";
  };

  installPhase = ''
    mkdir -p $out/share/icons
    cp -aR $src/Vivid\ Icons\ Themes/Vivid-Dark-Icons $out/share/icons
    gtk-update-icon-cache $out/share/icons/Vivid-Dark-Icons
  '';

  dontDropIconThemeCache = true;
}
