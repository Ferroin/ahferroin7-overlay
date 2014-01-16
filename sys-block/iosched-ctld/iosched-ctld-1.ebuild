# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="A program to do some user configurable tuning of I/O scheduling."
HOMEPAGE="https://github.com/Ferroin/ahferroin7-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 arm ppc sparc mips alpha hppa ia64 m64k sh -x86-fbsd -amd64-fbsd -sparc-fbsd"
IUSE=""

DEPEND="
sys-fs/inotify-tools
!sys-block/tune-iosched
"
RDEPEND="${DEPEND}"

src_unpack() {
	S="${WORKDIR}"
}

src_install() {
	doinitd "${FILESDIR}"/${PV}/init.d/iosched-ctld
	exeinto /usr/sbin
	exeopts "-m740"
	doexe "${FILESDIR}"/${PV}/iosched-ctld
	insinto /etc
	insopts "-m644"
	doins "${FILESDIR}"/${PV}/iosched-ctld.conf
}

pkg_postinst() {
	einfo "By default, iosched-ctld does nothing."
	einfo "To actually do anything, you need to edit /etc/iosched-ctld.conf"
}
