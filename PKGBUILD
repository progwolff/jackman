# Maintainer: Julian Wolff <wolff at julianwolff dot de>
pkgname=jackman
pkgver=0.1
pkgrel=1
pkgdesc='Collection of scripts that help managing multiple audio interfaces with Jack'
arch=('any')
url=''
license=('GPL')
#conflicts=()
#provides=()
depends=('jack2' 'alsa-utils' 'bash' 'systemd' 'coreutils')
makedepends=()
optdepends=('zenity: system notifications'
	   'kdebase-kdialog: system notifications')
source=()
md5sums=()
install=.install

package() {
  mkdir -p "$pkgdir/usr/bin"
  mkdir -p "$pkgdir/etc/udev/rules.d"
  mkdir -p "$pkgdir/usr/lib/systemd/system/"
  mkdir -p "$pkgdir/etc/xdg/autostart/"
  cp ../50-jackman.rules "$pkgdir/etc/udev/rules.d/"
  cp ../jackman "$pkgdir/usr/bin/"
  cp ../jackman_udev* "$pkgdir/usr/bin/"
  cp ../alsa* "$pkgdir/usr/bin/"
  cp ../*.service "$pkgdir/usr/lib/systemd/system/"
  cp ../*.desktop "$pkgdir/etc/xdg/autostart/"
  for d in `cd ../po; ls -1 *.po 2>/dev/null`; do
  	mkdir -p "$pkgdir/usr/share/locale/${d%.po}/LC_MESSAGES"
  	msgfmt -o "$pkgdir/usr/share/locale/${d%.po}/LC_MESSAGES/jackman.mo" ../po/${d} 
  done
}

