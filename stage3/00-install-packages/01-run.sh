#!/bin/bash -e

on_chroot << EOF
    cd /home/pi
    git clone https://www.github.com/EricssonResearch/calvin-base Calvin
    cd Calvin
    sudo pip install -r requirements -r test-requirements -e .
EOF

