# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Per-user Powerline daemns as OpenRC services"
HOMEPAGE="https://github.com/Ferroin/ahferroin7-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 arm arm64"

DEPEND=""
RDEPEND="
	${DEPEND}
	app-shells/powerline
	>=sys-apps/openrc-0.47.1"
BDEPEND=""

src_unpack() {
	S="${WORKDIR}"
}

src_install() {
	newinitd "${FILESDIR}/${PV}/powerline.init" "powerline"
}
