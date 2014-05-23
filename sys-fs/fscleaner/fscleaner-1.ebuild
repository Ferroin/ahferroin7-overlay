# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="A cron job to preform automated filesystem maintnence."
HOMEPAGE="https://github.com/Ferroin/ahferroin7-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 arm ppc sparc mips alpha hppa ia64 m64k sh -x86-fbsd -amd64-fbsd -sparc-fbsd"
IUSE=""

DEPEND=""
RDEPEND="
sys-apps/util-linux
${DEPEND}"

src_unpack() {
	S="${WORKDIR}"
}

src_install() {
	insinto /etc
	newins "${FILESDIR}"/${PV}/fscleaner.conf fscleaner.conf
	insinto /etc/cron.daily
	newins "${FILESDIR}"/${PV}/fscleaner.daily fscleaner
	insinto /etc/cron.weekly
	newins "${FILESDIR}"/${PV}/fscleaner.weekly fscleaner
	insinto /etc/cron.monthly
	newins "${FILESDIR}"/${PV}/fscleaner.monthly fscleaner
}

pkg_postinst() {
	einfo "Make sure that you edit /etc/fscleaner.conf to suit your needs."
	einfo
	einfo "Depending on what functionality you want, you may also need to install"
	einfo "some of the following packages:"
	einfo "    sys-fs/btrfs-progs (for BTRFS balance and scrub support)"
	einfo "    sys-fs/zerofree (for wiping free space with zeroes)"
	einfo "    sys-fs/e2fsprogs (for ext4 defragmentation support)"
}
