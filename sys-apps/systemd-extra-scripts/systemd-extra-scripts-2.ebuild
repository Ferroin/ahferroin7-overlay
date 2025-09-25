# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Extra scripts for working with systemd"
HOMEPAGE="https://github.com/Ferroin/ahferroin7-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"

DEPEND=""
RDEPEND="${DEPEND}
sys-apps/systemd"
BDEPEND=""

src_unpack() {
	S="${WORKDIR}"
}

src_install() {
	dobin "${FILESDIR}"/${PV}/systemd-sync-user-unit
}
