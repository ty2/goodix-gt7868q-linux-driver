# Maintainer: Terry Wong <terry.wong2@yahoo.com>

_repo=goodix-gt7868q-linux-driver
_module_name=goodix-gt7868q
pkgname=${__module_name}-dkms
pkgver=0.1.0
pkgrel=1
pkgdesc="The Goodix GT7868Q kernel modules (DKMS)"
url="https://github.com/ty2/goodix-gt7868q-linux-driver"
arch=('any')
license=('GPL2')
depends=('dkms')
makedepends=('git')
provides=("${_module_name}=${pkgver}-${pkgrel}")
conflicts=("${_pkgbase}")
//install=${pkgname}.install
source=("git+https://github.com/ty2/${_repo}#branch=master")
md5sums=(use 'updpkgsums')

package() {
  # Copy dkms.conf
  install -Dm644 ${_repo}/dkms.conf "${pkgdir}"/usr/src/${_module_name}-${pkgver}/dkms.conf

  # Copy sources (including Makefile)
  cp -r ${_repo}/* "${pkgdir}"/usr/src/${_module_name}-${pkgver}/

}