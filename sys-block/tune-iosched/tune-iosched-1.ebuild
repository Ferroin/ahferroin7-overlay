# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="An initscript to do some user configurable tuning of I/O scheduling."
HOMEPAGE="https://github.com/Ferroin/gentoo-utils-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 arm ~ppc ~sparc ~mips ~alpha ~hppa ~ia64 ~m64k ~sh -x86-fbsd -amd64-fbsd -sparc-fbsd"
IUSE=""

DEPEND="
!sys-block/iosched-ctld
"
RDEPEND="${DEPEND}"

src_unpack() {
	S="${WORKDIR}"
}

src_install() {
	doinitd "${FILESDIR}"/${PV}/tune-iosched
	doconfd "${FILESDIR}"/${PV}/conf/tune-iosched
}

pkg_postinst() {
	einfo "By default, tune-iosched does nothing."
	einfo "To actually do anything, you need to edit /etc/conf.d/tune-iosched."
}
