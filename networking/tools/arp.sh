#!/bin/bash

# arp (address resolution protocol) ===========================================
#
# The ARP command lets you view and modify a device’s ARP cache. 
#
# =============================================================================

function net::arp::apt-install() {
    sudo apt install net-tools
}

function net::arp::get-proc-cache() {
    cat /proc/net/arp
}

function net::arp::get-cache() {
    arp
}