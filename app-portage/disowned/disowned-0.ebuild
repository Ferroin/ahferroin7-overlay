# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="A simple program that uses equery to find files unclaimed by portage."
HOMEPAGE="https://github.com/Ferroin/ahferroin7-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 arm ~ppc ~sparc ~mips ~alpha ~hppa ~ia64 ~m64k ~sh"
IUSE=""

DEPEND=""
RDEPEND="
app-portage/gentoolkit
"

src_unpack() {
	S="${WORKDIR}"
}

src_install() {
	exeinto /usr/bin
	doexe "${FILESDIR}"/${PV}/disowned
}
