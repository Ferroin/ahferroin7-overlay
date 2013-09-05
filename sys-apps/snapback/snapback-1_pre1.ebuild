# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="LVM2 snapshot based deleted file recovery."
HOMEPAGE="https://github.com/Ferroin/ahferroin7-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
sys-fs/lvm2
virtual/cron"
RDEPEND="${DEPEND}"

src_prepare() {
	mkdir -p ${S}
	cp -ra "${FILESDIR}"/${PV} "${S}"
}

src_install() {
	exeinto /etc/cron.hourly
	doexe "${S}"/${PV}/snapback
	doexe "${S}"/${PV}/snapclean
	insinto /etc/conf.d
	newins "${S}"/${PV}/conf/snapback
}
