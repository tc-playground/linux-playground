#!/bin/bash

# SELinux =====================================================================
#
# SELinux is a Mandatory Access Control (MAC) system which is a kernel (LSM) 
# enhancement to confine programs to a limited set of resources.
#
# =============================================================================

# Instal SELinux.
# NB: Disable 'apparmour' first.
function selinux::apt-install() {
    sudo apt install -y selinux-utils policycoreutils
}

function selinux::config() {
    cat /etc/selinux/config
}

# Commands
# 
# getenforce
# setenforce 0
# sestatus


if [ ! -z "$1" ]; then
    selinux::$*
fi
