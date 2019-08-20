#!/bin/bash

# Dummy Interfaces ============================================================
#
# Command functions to create upto 255 'dummy network interfaces'. Each command
# takes an integer argument between 1-255 to denote the name and number of the 
# dummy interface to manage. The IP addresses of the interface matches the 
# the index. For example:
#
# ./dummy-interface.sh init
# ./dummy-interface.sh create 42
# ./dummy-interface.sh list
# ./dummy-interface.sh show 42
# ./dummy-interface.sh test 42
# ./dummy-interface.sh delete 42
# ./dummy-interface.sh destroy
# 
# The default names of the interfaces are 'dummy-<idx>' where 'idx' denotes the 
# the index. The 'DUMIFACE_NAME' environment variable can be used to alter this 
# default. It also namespace operations such as 'list'.
#
# The network is currently defined as: "10.0.0.<idx>/24"
# 


# Example underlying command flow =============================================
#
# sudo modprobe dummy numdummies=1 
#
# sudo ip link add dummy1 type dummy
# sudo ip addr add 10.0.0.1/24 dev dummy1
# sudo ip link set dummy1 up
#
# ip addr show dummy1
# ping -c 1 10.0.0.1
#
# sudo ip link set dummy1 down
# sudo ip addr del 10.0.0.1/24 dev dummy1
# sudo ip link del dummy1
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

[ -z "${DUMIFACE_NUM}" ] && export DUMIFACE_NUM="0"

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

# Default name / namesapce
[ -z "${DUMIFACE_NAME}" ] && export DUMIFACE_NAME="dummy"

# Default network CIDR.
DUMIFACE_ROOT_IP="10.0.0"
DUMIFACE_IP_CIDR="24"

# Create a dummy interface.
function net::dummy-iface::list() {
    ls -1 /sys/class/net/ | grep "${DUMIFACE_NAME}"
}

# Create a dummy interface.
function net::dummy-iface::create() {
    # e.g. '0'
    local iface_idx="${1:-1}"
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
    local iface_idx="${1:-1}"
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
    # The index/number of the dummy interface. e.g. '1, 2, etc.'
    local iface_idx="${1:-1}"
    # e.g. 'dummy0'
    echo "${DUMIFACE_NAME}-${iface_idx}"
}

function net::dummy-iface::get-ip() {
    # The index/number of the dummy interface. e.g. '1, 2, etc.'
    local iface_idx="${1:-1}"
    # e.g. idx = '0' -> '10.0.0.1'
    echo "10.0.0.${iface_idx}"
}

function net::dummy-iface::get-cidr() {
    # The index/number of the dummy interface. e.g. '1, 2, etc.'
    local iface_idx="${1:-1}"
    # e.g. '10.0.0.1'
    local iface_ip=$(net::dummy-iface::get-ip ${iface_idx})
    # Assume 3 byte subdomain. e.g. '10.0.0.1/24'
    echo "${iface_ip}/24"
}

function net::dummy-iface::show() {
    # The index/number of the dummy interface. e.g. '1, 2, etc.'
    local iface_idx="${1:-1}"
    # Check dummy interface device.
    local iface_name=$(net::dummy-iface::get-name ${iface_idx})
    ip addr show "${iface_name}"
}

function net::dummy-iface::test() {
    # The index/number of the dummy interface. e.g. '1, 2, etc.'
    local iface_idx="${1:-1}"
    # Check dummy interface device.
    local iface_ip=$(net::dummy-iface::get-ip ${iface_idx})
    ping -c 1 -W 3 "${iface_ip}"
}

# Main ========================================================================
#

function net::bonded-iface::help() {
    echo "Functions for managing 'dummy' ethernet interfaces."
}


if [ ! -z "$1" ]; then
    net::dummy-iface::$*
fi