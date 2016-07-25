# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="An initscript to handle setup of a swapfile"
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
	doinitd "${FILESDIR}"/${PV}/auto-swap
	doconfd "${FILESDIR}"/${PV}/conf/auto-swap
}

pkg_postinst() {
	einfo "Make sure that you edit /etc/cond.d/auto-swap before you start"
	einfo "auto-swap, otherwise it won't do anything."
}
