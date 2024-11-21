# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="A collection of init scripts to manage Linux kernel memory management features"
HOMEPAGE="https://github.com/Ferroin/ahferroin7-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 arm arm64 -x86-fbsd -amd64-fbsd"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

IUSE="+openrc systemd"
REQUIRED_USE="|| ( openrc systemd )"

src_unpack() {
	S="${WORKDIR}"
}

src_install() {
	for feature in ksm mglru thp; do
		if use openrc; then
			newconfd "${FILESDIR}/${PVR}/${feature}.conf" "${feature}"
			newinitd "${FILESDIR}/${PVR}/${feature}.init" "${feature}"
		fi

		if use systemd; then
			systemd_dounit "${FILESDIR}/${PVR}/${feature}.service"
		fi
	done
}
