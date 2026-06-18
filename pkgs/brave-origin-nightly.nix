{ lib, stdenv, fetchurl, dpkg, autoPatchelfHook, wrapGAppsHook3
, gtk3, glib, nss, nspr, atk, cups, dbus, expat, libdrm
, xorg, mesa, libxkbcommon, pango, cairo, alsa-lib
, at-spi2-atk, at-spi2-core }:

stdenv.mkDerivation rec {
  pname = "brave-origin-nightly";
  version = "1.93.67";

  src = fetchurl {
    url = "https://github.com/brave/brave-browser/releases/download/v${version}/${pname}_${version}_amd64.deb";
    sha256 = "1pnc7rc6k3xi4d55kf0pivwnkviy5vag6s9q6j8wb7ana59avvmf";
  };

  nativeBuildInputs = [ dpkg autoPatchelfHook wrapGAppsHook3 ];

  buildInputs = [
    gtk3 glib nss nspr atk cups dbus expat libdrm
    xorg.libX11 xorg.libXcomposite xorg.libXdamage
    xorg.libXext xorg.libXfixes xorg.libXrandr
    mesa libxkbcommon pango cairo alsa-lib
    at-spi2-atk at-spi2-core
  ];

  unpackPhase = "dpkg-deb -x $src .";

  installPhase = ''
    mkdir -p $out
    cp -r usr/* $out/
    mkdir -p $out/share/applications
    cp -r etc/. $out/etc 2>/dev/null || true
  '';

  meta = {
    description = "Brave Origin Nightly - minimalist privacy browser";
    homepage = "https://brave.com/origin";
    license = lib.licenses.mpl20;
    platforms = [ "x86_64-linux" ];
    mainProgram = "brave-origin-nightly";
  };
}
