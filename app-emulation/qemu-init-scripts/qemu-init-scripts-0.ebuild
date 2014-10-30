# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="An initscript to start a qemu instance."
HOMEPAGE="https://github.com/Ferroin/ahferroin7-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 arm ppc sparc mips alpha hppa ia64 m64k sh -x86-fbsd -amd64-fbsd -sparc-fbsd"
IUSE=""

DEPEND="
app-emulation/qemu
"
RDEPEND="${DEPEND}"

src_unpack() {
	S="${WORKDIR}"
}

src_install() {
	enweuser qemu -1 /bin/nologin /run 'disk,tty'
	doinitd "${FILESDIR}"/${PV}/qemu
	doconfd "${FILESDIR}"/${PV}/conf/qemu
}
