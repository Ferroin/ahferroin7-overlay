# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="A simple initscript for kernel crash dumps on Gentoo."
HOMEPAGE="https://github.com/Ferroin/ahferroin7-overlay"
SRC_URI=""

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
>=sys-apps/kexec-tools-2.0.4-r2"

src_unpack() {
	S="${WORKDIR}"
}

src_install() {
	newinitd "${FILESDIR}"/${PV}/kdump.initd kdump
	newconfd "${FILESDIR}"/${PV}/kdump.confd kdump
}
