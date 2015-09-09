# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{3_3,3_4} )

inherit python-any-r1

DESCRIPTION="A simple python script for mlocking files."
HOMEPAGE="https://github.com/Ferroin/ahferroin7-overlay"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
${PYTHON_DEPS}"

src_unpack() {
	S="${WORKDIR}"
}

src_install() {
	newinitd "${FILESDIR}"/${PV}/pymlock.initd pymlock
	newbin "${FILESDIR}"/${PV}/pymlock.py pymlock
	newconfd "${FILESDIR}"/${PV}/pymlock.confd pymlock
}

pkg_postinst() {
	einfo "An initscript has been installed that will start a daemonized instance of pymlock."
}
