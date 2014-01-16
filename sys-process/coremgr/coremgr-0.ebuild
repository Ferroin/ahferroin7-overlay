# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Basic secure coredump configuration for production systems."
HOMEPAGE="https://github.com/Ferroin/ahferroin7-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm ~ppc ~sparc ~mips ~alpha ~hppa ~ia64 ~m64k ~sh -x86-fbsd -amd64-fbsd -sparc-fbsd"
IUSE=""

DEPEND="
sys-process/cronbase
"
RDEPEND="${DEPEND}
virtual/cron
"

src_unpack() {
	S="${WORKDIR}"
}

src_install() {
	insinto /etc/sysctl.d
	newins "${FILESDIR}"/${PV}/sysctl coremgr.conf
	insinto /etc/cron.d
	newins "${FILESDIR}"/${PV}/cron coremgr
	keepdir /var/crash
}

pkg_postinst() {
	einfo "Crashdumps will be put in /var/crash."
	einfo
	einfo "By default, any crashdump older than one week will be deleted every,"
	einfo "day at midnight.  Make sure that if you need to save a dump, you"
	einfo "move it somewhere else."
}
