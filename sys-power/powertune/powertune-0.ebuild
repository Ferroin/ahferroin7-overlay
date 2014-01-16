# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="An initscript to do boot time configuration of power management."
HOMEPAGE="https://github.com/Ferroin/ahferroin7-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 arm ppc sparc mips alpha hppa ia64 m64k sh -x86-fbsd -amd64-fbsd -sparc-fbsd"
IUSE=""

DEPEND="
virtual/linux-sources
"
RDEPEND="${DEPEND}"

src_unpack() {
	S="${WORKDIR}"
}

src_install() {
	doinitd "${FILESDIR}"/${PV}/powertune
	doconfd "${FILESDIR}"/${PV}/conf/powertune
}
