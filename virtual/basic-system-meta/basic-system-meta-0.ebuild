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
app-admin/logrotate
app-admin/sudo
app-misc/screen
net-firewall/iptables
sys-devel/bc
virtual/acl
virtual/cron
virtual/logger
virtual/mta
|| (
	app-editors/vim
	app-editors/nvi
	app-editors/vile
	app-editors/neovim
)
"
