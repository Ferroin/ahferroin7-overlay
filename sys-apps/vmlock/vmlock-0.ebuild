# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="An initscript to start vmtouch to lock memory"
HOMEPAGE="https://github.com/Ferroin/ahferroin7-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 arm ppc sparc mips alpha hppa ia64 m64k sh -x86-fbsd -amd64-fbsd -sparc-fbsd"
IUSE=""

DEPEND="
"
RDEPEND="
dev-util/vmtouch
${DEPEND}"

src_unpack() {
	S="${WORKDIR}"
}

src_install() {
	newinitd "${FILESDIR}"/${PV}/vmlock.initd vmlock
	newbin "${FILESDIR}"/${PV}/bindeps.py bindeps.py
	newconfd "${FILESDIR}"/${PV}/vmlock.confd vmlock
}

pkg_postinst() {
	einfo "You may want to edit /etc/conf.d/vmtouch to select what files get locked."
}
