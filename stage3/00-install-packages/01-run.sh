#!/bin/bash -e

# fetch pip
wget https://bootstrap.pypa.io/get-pip.py -O files/get-pip.py
cp files/get-pip.py ${ROOTFS_DIR}/tmp

# fetch calvin
wget https://github.com/EricssonResearch/calvin-base/archive/master.zip -O files/calvin.zip

install -v -o 1000 -g 1000 -d ${ROOTFS_DIR}/home/pi/Calvin
unzip files/calvin.zip -d ${ROOTFS_DIR}/home/pi/Calvin
chown 1000:1000 ${ROOTFS_DIR}/home/pi/Calvin -Rv

on_chroot << EOF
    cd /tmp
    sudo python get-pip.py
    sudo pip install -U six
    cd /home/pi/Calvin/calvin-base-master
    sudo pip install -r requirements.txt
    sudo pip install -r test-requirements.txt
    sudo pip install -e .
EOF

