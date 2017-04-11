#!/bin/bash -e

CALVIN_GITREF=${CALVIN_GITREF:-master}

CALVIN_BUNDLE="files/calvin.tgz"

# fetch pip
wget https://bootstrap.pypa.io/get-pip.py -O files/get-pip.py
mv files/get-pip.py ${ROOTFS_DIR}/tmp

# Fetch calvin
curl -L "https://api.github.com/repos/EricssonResearch/calvin-base/tarball/$CALVIN_GITREF" > $CALVIN_BUNDLE

install -v -o 1000 -g 1000 -d ${ROOTFS_DIR}/home/pi/Calvin
tar zxvf $CALVIN_BUNDLE -d ${ROOTFS_DIR}/home/pi/Calvin
chown 1000:1000 ${ROOTFS_DIR}/home/pi/Calvin -Rv

cp files/calvin.conf ${ROOTFS_DIR}/home/pi/Calvin
cp files/standard-pins.json ${ROOTFS_DIR}/home/pi/Calvin

on_chroot << EOF
    cd /tmp
    sudo python get-pip.py
    sudo pip install -U six
    cd /home/pi/Calvin/EricssonResearch-calvin-base-*
    sudo pip install -r requirements.txt
    sudo pip install -r test-requirements.txt
    sudo pip install -e .
EOF

# Cleanup
rm -fr ${ROOTFS_DIR}/home/pi/Calvin/EricssonResearch-calvin-base-*
rm -f  ${ROOTFS_DIR}/tmp/get-pip.py
