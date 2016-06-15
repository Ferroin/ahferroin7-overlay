# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="An initscript to setup swap on a compressed ramdisk."
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

pkg_pretend() {
	CONFFILE="/dev/null"
	if [[ -e "${ROOT}"/usr/src/linux/.config ]] ; then
		CONFFILE="${ROOT}"/usr/src/linux/.config
		einfo "Using kernel config at" "${ROOT}"/usr/src/linux/.config
	else
		if [[ -e "${ROOT}"/lib/modules/"`uname -r`"/build/.config ]] ; then
			CONFFILE="${ROOT}"/lib/modules/"`uname -r`"/build/.config
			einfo "Using kernel config at" "${ROOT}"/lib/modules/"`uname -r`"/build/.config
		else
			ewarn "Couldn't find a usable kernel config, trying /proc/config.gz..."
			if [[ -e "${ROOT}"/proc/config.gz ]] ; then
				zcat "${ROOT}"/proc/config.gz > "${S}"/config
				CONFFILE="${S}"/config
				einfo "Using kernel config found in /proc/config.gz."
			else
				ewarn "Couldn't find any usable kernel config."
				ewarn "Checking for zram sysfs or module."
				# At this point, we try some last ditch efforts to find zram support
				if [[ -e "${ROOT}"/lib/modules/"`uname -r`"/kernel/drivers/staging/zram/zram.ko ]] ; then
					einfo "Found ZRAM kernel module, assuming we can use it."
					return 0
				fi
				if [[ -d "${ROOT}"/sys/module/zram ]] ; then
					einfo "Found ZRAM sysfs node, assuming we have zram support."
					return 0
				fi
				if [[ -b "${ROOT}"/dev/zram ]] ; then
					einfo "Found ZRAM device node, assuming we have zram support."
					return 0
				fi
				die "Couldn't verify that we have ZRAM support."
			fi
		fi
	fi
	einfo "Checking for CONFIG_ZRAM in the kernel configuration..."
	if grep -x -q -E "^CONFIG_ZRAM=(m|y)$" "${CONFFILE}" ; then
		return 0
	else
		eerror "Couldn't find CONFIG_ZRAM in the kernel configuration."
		eerror "Make sure that it is set to either 'y' or 'm' before"
		eerror "trying to use zram-swap."
		die
	fi
}

src_unpack() {
	S="${WORKDIR}"
}

src_install() {
	doinitd "${FILESDIR}"/${PV}/zram-swap
	doconfd "${FILESDIR}"/${PV}/conf/zram-swap
}
