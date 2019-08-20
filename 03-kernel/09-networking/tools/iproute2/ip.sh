#!/bin/bash

# ip addr =====================================================================
#
# IP Layer Commands (L3-ish?)
#
# * Display device state.
# * Add interfaces (ip addresses) to a device. NB: Multiple can be added.
# * Remove interfaces (ip addresses) from a device.
#
# NB: The ip address identifies the interface on the device.
#

# Show all device interfaces (addresses).
# -c     : Coloured.
function net::ip::iface-list() {
    ip -c addr
}

# Show summary of all device interfaces (addresses).
# -c     : Coloured.
# -brief : Display summary output.
# -4/-6  : Toggle IPv4 and IPv6 addresses only.
function net::ip::iface-summary-list() {
    ip -c -brief addr
}

# Add an interface (address) to a device.
# Multiple addresses cn be added to a device.
# -4/-6  : Configure IPv4 and IPv6 addresses. IPv4 default.
function net::ip::iface-add() {
    local ip_cidr=$1
    local name=$2
    ip addr add "${ip_cidr}" dev "${name}"
}

# Delete an interface (address) from a device.
function net::ip::iface-delete() {
    local ip_cidr=$1
    local name=$2
    ip addr del "${ip_cidr}" dev "${name}"
    ip addr flush dev "${name}"
}


# ip link =====================================================================
#
# Link Layer Commands (L2-ish?)
#
# 1. Manage the state of a devices link: enable, disable, etc.
# 2. Manage the configuration of a devices link: name, MAC addr, MTU, etc.
#

# Show all device interfaces (addresses).
# -c     : Coloured.
function net::ip::device-list() {
    ip -c link
}

# Show summary of all device interfaces (addresses).
# -c     : Coloured.
# -brief : Display summary output.
# -4/-6  : Toggle IPv4 and IPv6 addresses only.
function net::ip::device-summary-list() {
    ip -c -brief link
}

# Enable a device.
function net::ip::device-enable() {
     local name=$1
    ip link set dev "${name}" up
}

# Disable a device.
function net::ip::device-disable() {
     local name=$1
    ip link set dev "${name}" down
}

# Set MAC address of a device.
function net::ip::device-macaddr-set() {
    local mac_addr=$1
    local name=$2
    ip link set addr "${mac_addr}" dev "${name}"
}

# Set MTU of a device.
function net::ip::device-macaddr-set() {
    local mtu=$1
    local name=$2
    ip link set mtu "${mtu}" dev "${name}"
}

# Set name of a device.
function net::ip::device-name-set() {
    local old_name=$1
    local new_name=$2
    ip link set name "${old_name}" dev "${new_name}"
}

# ip neighbour ================================================================
# 
# Arp table commands.
#

# Show the arp table.
# -c     : Coloured.
function net::ip::arp-table-list() {
    ip -c neighbor
}

# Add arp table entry.
function net::ip::arp-table-add() {
    local ip_addr=$1
    local mac_addr=$2
    local name=$3
    ip neighbor add "$(ip_addr)" lladdr "$(mac_addr)" dev "$(name)"
}

# Delete arp table entry.
function net::ip::arp-table-remove() {
    local ip_addr=$1
    local mac_addr=$2
    local name=$3
    ip neighbor delete "$(ip_addr)" lladdr "$(mac_addr)" dev "$(name)"
}

# Clear the arp table.
function net::ip::arp-table-clear() {
    local name=$1
    ip neighbor flush dev  dev "$(name)"
}

# ip route ====================================================================
# 
# Route table commands.
#

# Show the route table.
# -c     : Coloured.
function net::ip::route-table-list() {
    ip -c route
}

# Get selected route for destination.
function net::ip::route-for-host() {
    local dest_host=$1
    net::ip::route-for-ip $(host ${dest_host} | head -n 1 | awk '{print $4}')
}

# Get selected route for destination.
function net::ip::route-for-ip() {
    local dest_ip=$1
    ip -c route get "${dest_ip}"
}

# Add default route.
function net::ip::route-table-default() {
    local next_hop_ip=$1
    net::ip::route-table-add default "${next_hop_ip}"
}

# Add route.
function net::ip::route-table-add() {
    local nw_cidr=$1
    local next_hop_ip=$2
    ip route add "${nw_cidr}" via "${next_hop_ip}"
}

# Del route.
function net::ip::route-table-delete() {
    local nw_cidr=$1
    local next_hop_ip=$2
    ip route del "${nw_cidr}"
}


# Main ========================================================================
#

if [ ! -z "$1" ]; then
    net::ip::$*
fi