# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Virtual to provide rough parity with other distros base installs"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=""
RDEPEND="
virtual/basic-system-meta
sys-kernel/linux-firmware
sys-power/pm-utils
|| (
	net-misc/ntp
	net-misc/ntpclient
	net-misc/openntpd
	net-misc/chrony
	net-misc/clockspeed
	net-misc/netdate
	net-misc/ptpd
)
"
