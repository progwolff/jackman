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
depends=('jack2' 'alsa-utils' 'bash' 'systemd')
makedepends=()
optdepends=('zenity: system notifications'
	   'kdebase-kdialog: system notifications')
source=()
md5sums=()
#install=.install

package() {
  mkdir -p "$pkgdir/usr/bin"
  mkdir -p "$pkgdir/etc/udev/rules.d"
  mkdir -p "$pkgdir/etc/systemd/system/"
  cp ../50-jackman.rules "$pkgdir/etc/udev/rules.d/"
  cp ../jackman "$pkgdir/usr/bin/"
  cp ../jackman_udev* "$pkgdir/usr/bin/"
  cp ../alsa* "$pkgdir/usr/bin/"
  cp ../*.service "$pkgdir/etc/systemd/system/"
}

