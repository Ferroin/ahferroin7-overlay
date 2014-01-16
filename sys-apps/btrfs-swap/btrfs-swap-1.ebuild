# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="An initscript to setup a swap file on BTRFS."
HOMEPAGE="https://github.com/Ferroin/ahferroin7-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 arm ppc sparc mips alpha hppa ia64 m64k sh -x86-fbsd -amd64-fbsd -sparc-fbsd"
IUSE=""

DEPEND="
"
RDEPEND="${DEPEND}"

src_unpack() {
	S="${WORKDIR}"
}

src_install() {
	doinitd "${FILESDIR}"/${PV}/btrfs-swap
	doconfd "${FILESDIR}"/${PV}/conf/btrfs-swap
}

pkg_postinst() {
	einfo "Make sure that you edit /etc/cond.d/btrfs-swap before you start"
	einfo "btrfs-swap, otherwise it won't do anything."
	einfo
	einfo "You should also consider stopping btrfs-swap whenever you"
	einfo "run a filesystem balance, as the presence of a swapfile might"
	einfo "make the balance take a very long time"
}
