# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

CROS_WORKON_REPO="git://github.com/raspberrypi"
CROS_WORKON_PROJECT="linux"
CROS_WORKON_EGIT_BRANCH="rpi-4.4.y"
CROS_WORKON_BLACKLIST="1"
CROS_WORKON_COMMIT="497964619e08c122d8cc37f0271d83d24d0380ce"

# This must be inherited *after* EGIT/CROS_WORKON variables defined
inherit git-2 cros-kernel2 cros-workon

DESCRIPTION="Chrome OS Kernel-raspberrypi2-kms"
KEYWORDS="arm"
KERNEL="kernel7"

DEPEND="!sys-kernel/chromeos-kernel-next
	!sys-kernel/chromeos-kernel
"
RDEPEND="${DEPEND}"

#TODO: install dtbs from source build.
src_install() {
	cros-kernel2_src_install
        "${FILESDIR}/mkknlimg" \
                "$(cros-workon_get_build_dir)/arch/arm/boot/zImage" \
                "${T}/dtImage"

        insinto /boot
        doins "${FILESDIR}"/{cmdline,config}.txt
        doins "${T}/dtImage"
	doins "${FILESDIR}/bcm2709-rpi-2-b.dtb"
}