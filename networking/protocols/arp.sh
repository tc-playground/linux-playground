#!/bin/bash

# arp (address resolution protocol) ===========================================
#
# The ARP command lets you view and modify a device’s ARP cache. 
#
# =============================================================================

function net::arp::sniff-arp() {
    sudo tcpdump arp
}

function net::arp::sniff-arp-packets {
    sudo tcpdump -ttttXXl arp
}

function net::arp::get-cache() {
    ip -c neigh
}

# Main ========================================================================
#

if [ ! -z "$1" ]; then
    net::arp::$*
fi
