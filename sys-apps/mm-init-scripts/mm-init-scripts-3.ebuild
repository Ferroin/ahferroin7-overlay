# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A collection of init scripts to manage Linux kernel memory management features"
HOMEPAGE="https://github.com/Ferroin/ahferroin7-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 arm arm64 -x86-fbsd -amd64-fbsd"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	S="${WORKDIR}"
}

src_install() {
	for feature in ksm mglru thp; do
		newconfd "${FILESDIR}/${PV}/${feature}.conf" "${feature}"
		newinitd "${FILESDIR}/${PV}/${feature}.init" "${feature}"
		insinto "${ROOT}/usr/lib/systemd/system"
		newins "${FILESDIR}/${PV}/${feature}.service" "${feature}.service"
	done
}
