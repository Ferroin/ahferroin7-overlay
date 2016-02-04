# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="A quick tool to check if we need to reboot to finish an update."
HOMEPAGE="https://github.com/Ferroin/ahferroin7-overlay"
SRC_URI=""

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
>=app-portage/eix-0.31.1
"

src_unpack() {
	S="${WORKDIR}"
}

src_install() {
	newinitd "${FILESDIR}"/${PV}/check-reboot.initd check-reboot
	newconfd "${FILESDIR}"/${PV}/check-reboot.confd check-reboot
	exeinto /usr/bin
	newexe "${FILESDIR}"/${PV}/check-reboot check-reboot
}
