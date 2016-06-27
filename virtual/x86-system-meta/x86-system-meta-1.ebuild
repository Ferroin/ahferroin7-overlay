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
virtual/phys-system-meta
app-admin/mcelog
sys-apps/dmidecode
sys-apps/hdparm
sys-apps/irqbalance
sys-apps/pciutils
sys-apps/usbutils
sys-firmware/intel-microcode
sys-power/acpid
"
