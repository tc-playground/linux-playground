#!/bin/bash

function net-tools::apt-install() {
    sudo apt install net-tools
}

# arp (address resolution protocol) ===========================================
#
# The ARP command lets you view and modify a device’s ARP cache. 

function net-tools::procfs-arpcache-get() {
    cat /proc/net/arp
}

function net-tools::arpcache-get() {
    arp
}

# Main ========================================================================
#

if [ ! -z "$1" ]; then
    net-tools::$*
fi