#!/bin/bash

# Dummy Interfaces ============================================================
#
# Command functions to create upto 255 'dummy network interfaces'. Each command
# takes an integer argument between 0-255 to denote the name and number of the 
# dummy interface to manage. The IP addresses of the interface matches the 
# the index.
#

# Example underlying command flow =============================================
#
# sudo modprobe dummy numdummies=1 
#
# sudo ip link add dummy0 type dummy
# sudo ip addr add 10.0.0.1/24 dev dummy0
# sudo ip link set dummy0 up
#
# ip addr show dummy0
# ping -c 1 10.0.0.1
#
# sudo ip link set dummy0 down
# sudo ip addr del 10.0.0.1/24 dev dummy0
# sudo ip link del dummy0 
#
# sudo rmmod dummy
# 


# References ================================================================== 
#
# * https://serverfault.com/questions/516366/how-virbr0-nic-is-created
# * http://wiki.networksecuritytoolkit.org/index.php/Dummy_Interface
#


# Kernel dummy network driver =================================================
#

[ -z "${DUMIFACE_NUM}" ] && export DUMIFACE_NUM="1"
DUMIFACE="dummy"

# Initialise dummy network driver and create N dummy interfaces.
# These will be named: {dummy0, dummy1, ... , dummyN}
function net::dummy-iface::init() {
    local num_dummies="${1:-${DUMIFACE_NUM}}"

    # [Optional] ADD resolvable hostname,
    # echo 10.0.0.1 ${HOSTNAME} >> /etc/hosts
    
    # ENABLE the kernel 'dummy interface driver'.
    modprobe dummy numdummies="${DUMIFACE_NUM}"
}

# Destroy the dummy network driver and associated interface.
function net::dummy-iface::destroy() {
    rmmod dummy
}

# Dummy interface management ==================================================
#
# * https://serverfault.com/questions/516366/how-virbr0-nic-is-created
# * http://wiki.networksecuritytoolkit.org/index.php/Dummy_Interface
#

DUMIFACE_ROOT_IP="10.0.0"
DUMIFACE_IP_CIDR="24"

# Create a dummy interface.
function net::dummy-iface::list() {
    ls -1 /sys/class/net/ | grep 'dummy'
}

# Create a dummy interface.
function net::dummy-iface::create() {
    # e.g. '0'
    local iface_idx="${1:-0}"
    # e.g. 'dummy0'
    local iface_name=$(net::dummy-iface::get-name ${iface_idx})
    # e.g. '10.0.0.1/24'
    local iface_cidr=$(net::dummy-iface::get-cidr ${iface_idx})

    # CREATE a dummy interface device.
    sudo ip link add "${iface_name}" type dummy

    # BIND and IPv4 CIDR address to the dummy interface.
    sudo ip addr add "${iface_cidr}" dev "${iface_name}"

    # ENABLE dummy interface device.
    sudo ip link set "${iface_name}" up
}

# Delete a dummy interface.
function net::dummy-iface::delete() {
    # e.g. '0'
    local iface_idx="${1:-0}"
    # e.g. 'dummy0'
    local iface_name=$(net::dummy-iface::get-name ${iface_idx})
    # e.g. '10.0.0.1/24'
    local iface_cidr=$(net::dummy-iface::get-cidr ${iface_idx})

    # DISABLE dummy interface device.
    sudo ip link set "${iface_name}" down

    # UNBIND and IPv4 CIDR address to the dummy interface.
    sudo ip addr del "${iface_cidr}" dev "${iface_name}"

    # DELETE a dummy interface device.
    sudo ip link del "${iface_name}" type dummy
}

function net::dummy-iface::get-name() {
    # The index/number of the dummy interface. e.g. '0, 1, 2, etc.'
    local iface_idx="${1:-0}"
    # e.g. 'dummy0'
    echo "dummy${iface_idx}"
}

function net::dummy-iface::get-ip() {
    # The index/number of the dummy interface. e.g. '0, 1, 2, etc.'
    local iface_idx="${1:-0}"
    # Assign each dummy device a subnet ip addr one above it's 'idx'.
    local subnet_ip=$((iface_idx+1))
    # e.g. idx = '0' -> '10.0.0.1'
    echo "10.0.0.${subnet_ip}"
}

function net::dummy-iface::get-cidr() {
    # The index/number of the dummy interface. e.g. '0, 1, 2, etc.'
    local iface_idx="${1:-0}"
    # e.g. '10.0.0.1'
    local iface_ip=$(net::dummy-iface::get-ip ${iface_idx})
    # Assume 3 byte subdomain. e.g. '10.0.0.1/24'
    echo "${iface_ip}/24"
}

function net::dummy-iface::show() {
    # The index/number of the dummy interface. e.g. '0, 1, 2, etc.'
    local iface_idx="${1:-0}"
    # Check dummy interface device.
    local iface_name=$(net::dummy-iface::get-name ${iface_idx})
    ip addr show "${iface_name}"
}

function net::dummy-iface::test() {
    # The index/number of the dummy interface. e.g. '0, 1, 2, etc.'
    local iface_idx="${1:-0}"
    # Check dummy interface device.
    local iface_ip=$(net::dummy-iface::get-ip ${iface_idx})
    ping -c 1 -W 3 "${iface_ip}"
}

# Main ========================================================================
#

if [ ! -z "$1" ]; then
    net::dummy-iface::$*
fi