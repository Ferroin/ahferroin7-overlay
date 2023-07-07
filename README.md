# ahferroin7’s Portage overlay.

Some of the stuff in here is stuff that I wrote myself and am to lazy
to put in it's won repo, other stuff is versions that aren't (or weren't
at some point) availible in the regular protage tree.

## Using it

### With eselect repository

Just run `eselect repository add ahferroin7-overlay git git://github.com/Ferroin/ahferroin7-overlay`
to add the overlay to your system.

### With Layman

To use this with layman, you need to update your layman configuration to point at
https://raw.githubusercontent.com/Ferroin/ahferroin7-overlay/master/overlays.xml
as an additional unsigned overlay list.

## Contents

Currently, the things I've wrtten in here are:
app-portage/check-reboot        Check to see if we've updated any of a
                                set of packages and thus need to reboot.
app-portage/disowned            A shell script to automate finding
                                files that aren't owned by any package.
app-portage/portage-tools-meta  Simple meta-package that pulls in a
                                handful of useful portage tools that
                                arguably should be in the standard
                                install.
sys-apps/auto-swap              An initscript to do advanced swapfile
                                setup.
sys-apps/kdump-init             A simple (and somewhat naieve) initscript
                                to set up and run kernel crash dumps.
sys-apps/mm-init-scripts        A collection of init scripts to set up
                                various Linux memory management features.
sys-apps/pymlock                A python script to mlock arbitrary files,
                                including an initscript to be used as
                                a replacement for memlockd.
sys-apps/vmlock                 A initscript intended to replace pymlock,
                                it uses dev-util/vmtouch for the actual
                                locking, and is more efficient overall.
                                Also includes a python script with the
                                file list expansion logic from pymlock.
sys-apps/zram-swap              An initscript to setup swap on a compressed
                                ramdisk.
sys-fs/fscleaner                A cron job to automate basic filesystem
                                maintnence tasks.
virtual/basic-system-meta       Pulls in some of the packages that most
                                other distros include by default, but
                                Gentoo doesn't.
virtual/phys-system-meta        Same as above, just adds more which are
                                normally only used on physical hardware
                                (instad of in VM's).
virtual/x86-system-meta         Same as above, just adds more which are
                                usually standard on x86 systems, but
                                may not be needed on others.

And this is a list of 3rd-party stuff:
app-crypt/certbot-dns-route53   Amazon Route 53 plugin for Certbot,
                                will be removed when it finally gets
                                added to portage.
dev-python/nbt2yaml             A library and tools for converting
                                Minecraft's NBT format to YAML
www-servers/micro_httpd         Tiny inetd based HTTP/1.0 server.
