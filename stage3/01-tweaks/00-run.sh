#!/bin/bash -e

rm -f ${ROOTFS_DIR}/etc/systemd/system/dhcpcd.service.d/wait.conf

# set vim as editor
on_chroot << EOF
	sudo update-alternatives --set editor /usr/bin/vim.basic
EOF
