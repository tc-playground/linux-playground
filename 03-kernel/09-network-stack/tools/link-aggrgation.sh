#!/bin/bash

# Bonded Interfaces ============================================================
#

# INIT: Enable 'bonding' kernel module.
function net::link-aggregation::bonding-mod-enable() {
    modprobe bonding
}

# CREATE: Create a 'bonded' ethernet interface.
function net::link-aggregation::bonded-iface-create() {
    local bonded_iface="${1:-bond0}"
    sudo ip link add "${bonded_iface}" type bond mode 802.3ad
}

# DELETE: Delete a ('bonded' ethernet) interface.
function net::link-aggregation::bonded-iface-delete() {
    local bonded_iface="${1:-bond0}"
    sudo ip link del dev "${bonded_iface}"
    sudo ip link set "${bonded_iface}" up
}

# ADD: Add the (physical) interface to bonded device.
function net::link-aggregation::bonded-iface-add() {
    local iface="${1:-enp5s0}"
    local bonded_iface="${1:-bond0}"
    sudo ip link set "${iface}" master "${bonded_iface}"
}

# REMOVE: Remove the (physical) interface from bonded device.
function net::link-aggregation::bonded-iface-remove() {
    local iface="${1:-enp5s0}"
    sudo ip link set "${iface}" nomaster
}

# CREATE POLICY: Set 'round-robin' policy.
function net::link-aggregation::bonded-iface-create-policy() {
    local bonded_iface="${1:-bond0}"
    echo "balance-rr" > /sys/class/net/"${bonded_iface}"/bonding
}


# Teamed Interfaces ============================================================
#

# CREATE: Create a 'teamed' ethernet interface.
function net::link-aggregation::teamed-iface-create() {
    local team_iface="${1:-team0}"
    # nmcli con add type team con-name "${team_iface}"
    # if iface exists: 
    # ip link add link "${team_iface}" type team
    sudo ip link add "${team_iface}" type team
}

# DELETE: Delete a ('teamed' ethernet) interface.
function net::link-aggregation::teamed-iface-delete() {
    local team_iface="${1:-team0}"
    # nmcli con del "${team_iface}"
    sudo ip link del dev "${team_iface}"
}

# ADD: Add the (physical) interface to teamded device.
function net::link-aggregation::teamed-iface-add() {
    local iface="${1:-enp5s0}"
    local teamed_iface="${1:-team0}"
    sudo ip link set "${iface}" master "${teamed_iface}"
}

# REMOVE: Remove the (physical) interface from teamded device.
function net::link-aggregation::teamed-iface-remove() {
    local iface="${1:-enp5s0}"
    sudo ip link set "${iface}" nomaster
}

# Main ========================================================================
#
function net::link-aggregation::connection-list() {
    nmcli con show
}

function net::link-aggregation::help() {
    echo "Functions for managing 'bonded' and 'teamed' L2 ethernet interfaces."
}

if [ ! -z "$1" ]; then
    net::link-aggregation::$*
fi