# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Automated update script for Gentoo"
HOMEPAGE="https://github.com/Ferroin/gentoo-utils-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm ~ppc ~sparc ~mips"
IUSE=""

DEPEND=""
RDEPEND="
>=dev-lang/python-3.2
app-arch/dump
"

src_unpack() {
	S=${WORKDIR}
}

src_install() {
	exeinto /etc/cron.hourly
	doexe "${FILESDIR}"/${PV}/backtrack
	doconfd "${FILESDIR}"/${PV}/conf/backtrack
}

pkg_postinst() {
	echo
	einfo "Make sure that you edit /etc/conf.d/backtrack to suit your needs"
	echo
}
