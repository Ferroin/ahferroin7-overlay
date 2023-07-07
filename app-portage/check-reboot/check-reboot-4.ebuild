# Copyright 2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A quick tool to check if we need to reboot to finish an update."
HOMEPAGE="https://github.com/Ferroin/ahferroin7-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
>=app-portage/portage-utils-0.96
"

src_unpack() {
	S="${WORKDIR}"
}

src_install() {
	insinto /etc
	doins "${FILESDIR}"/${PV}/check-reboot.conf
	newbin "${FILESDIR}"/${PV}/check-reboot check-reboot
}

pkg_preinst() {
	if has_version "<app-portage/check-reboot-4"; then
		CHECK_REBOOT_NO_INIT=1
	fi
}

pkg_postinst() {
	if [ -n "${CHECK_REBOOT_NO_INIT}" ]; then
		ewarn "Starting with version 4, app-portage/check-reboot no longer needs an init script run at system startup."
		ewarn "If you have the init script enabled, you should remove it from whatever runlevels it was in."
	fi
}
