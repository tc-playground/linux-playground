#!/bin/bash

# TODO
# * Unattended install.
# * Investigate `clone`.


[ -z "${LIBVIRT_URL}" ] && export LIBVIRT_URL="qemu:///system"

# Networking ==================================================================
#
# * https://libvirt.org/formatnetwork.html
#

[ -z "${LIBVIRT_NETWORK_NAME}" ] && export LIBVIRT_NETWORK_NAME="default"
[ -z "${LIBVIRT_NETWORK_SPEC}" ] && export LIBVIRT_NETWORK_SPEC="${PWD}/network.xml"

# LIST virtual networks. [net-list]
function vm::network-list() {
    local url="${1:-${LIBVIRT_URL}}"
    virsh -c "${url}" net-list --all
}

# GET the named network. [net-dump]
function vm::network-get() {
    local name="${1:-${LIBVIRT_NETWORK_NAME}}"
    local url="${2:-${LIBVIRT_URL}}"
    virsh -c "${url}" net-dumpxml "${name}"
}

# EDIT the named network. [net-edit]
function vm::network-edit() {
    local name="${1:-${LIBVIRT_NETWORK_NAME}}"
    local url="${2:-${LIBVIRT_URL}}"
    virsh -c "${url}" net-edit "${name}"
}

# CREATE a named network. [net-define]
function vm::network-create() {
    local nw_spec="${1:-${LIBVIRT_NETWORK_SPEC}}"
    local url="${2:-${LIBVIRT_URL}}"
    virsh -c "${url}" net-define "${nw_spec}"
}

# DELETE a named network. [net-undefine]
function vm::network-delete() {
    local name="${1:-${LIBVIRT_NETWORK_NAME}}"
    local url="${2:-${LIBVIRT_URL}}"
    virsh -c "${url}" net-undefine "${name}"
}

# START a named network. [net-start]
function vm::network-start() {
    local name="${1:-${LIBVIRT_NETWORK_NAME}}"
    local url="${2:-${LIBVIRT_URL}}"
    virsh -c "${url}" net-start "${name}" > /dev/null
    if [ $? == 0 ]; then
        echo "Network default started"
    fi
}

# STOP a named network. [net-destroy]
function vm::network-stop() {
    local name="${1:-${LIBVIRT_NETWORK_NAME}}"
    local url="${2:-${LIBVIRT_URL}}"
    virsh -c "${url}" net-destroy "${name}" > /dev/null
    if [ $? == 0 ]; then
        echo "Network default stopped"
    fi
}

# AUTOSTART a named network on boot. [net-autostart]
function vm::network-autostart() {
    local name="${1:-${LIBVIRT_NETWORK_NAME}}"
    local url="${2:-${LIBVIRT_URL}}"
    virsh -c "${url}" net-autostart "${name}"
}

# Generate a network definition template.
# TODO - Add function to create new bridge.
function vm::network-generate-network-spec() {
    local name="${1:-${LIBVIRT_NETWORK_NAME}}"
    local nw_spec="${2:-`pwd`/${name}-network.xml}"
    if [ -f "${nw_spec}" ]; then
        echo "The network specification file alreay exists: '${nw_spec}'"
        exit 1
    fi
    # Generate random ids. NB: MAC prefix 02 denotes 'local' assigned addresses.
    local uuid=$(uuid)
    local mac_addr=$(echo `date` | md5sum | sed 's/^\(..\)\(..\)\(..\)\(..\)\(..\).*$/02:\1:\2:\3:\4:\5/')
    # Write network configuration.
    cat > "${nw_spec}" << EOF
<network>
  <name>${name}</name>
  <uuid>${uuid}</uuid>
  <forward mode='nat'>
    <nat>
      <port start='1024' end='65535'/>
    </nat>
  </forward>
  <bridge name='virbr0' stp='on' delay='0'/>
  <mac address='${mac_addr}'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
    </dhcp>
  </ip>
</network>
EOF
    echo "Generated default network template: '${nw_spec}'"
}

# Show bridge info.
#
# virbr0 should have been assigned a valid ip (by dhcp via dnsmasq).
#
# e.g: 192.168.122.1/24
#
function vm::network-bridge-info() {
    local name="${1:-${LIBVIRT_NETWORK_BRIDGE}}"
    ip -c addr show "${name}"
    ip -c addr show "${name}-nic"
}

# Check of dnsmasq is running. dnsmasq is started by libvirt.
#
# dnsmasq should be running on port 53 fo both udp and tcp. 
#
function vm::dnsmasq-status-show() {
    # Check dnsmasq is running.
    ps uf -C dnsmasq
    # sudo ss -nlptu | grep dnsmasq
    sudo netstat -nlptu | grep dnsmasq
}

# Check ip tables.
# 
# |*| - Firewall rules 
#
# Should allow dnsmasq (53) and dhcp (67) traffic through.
#
# INPUT chain should: 
#   ACCEPT input on virbr0 on udp/tcp port '53' (dnsmaq) and '67' (dhcp)
#
# Chain INPUT (policy ACCEPT 64834 packets, 18M bytes)
#  pkts bytes target     prot opt in     out     source               destination         
#     0     0 ACCEPT     udp  --  virbr0 *       0.0.0.0/0            0.0.0.0/0            udp dpt:53
#     0     0 ACCEPT     tcp  --  virbr0 *       0.0.0.0/0            0.0.0.0/0            tcp dpt:53
#     0     0 ACCEPT     udp  --  virbr0 *       0.0.0.0/0            0.0.0.0/0            udp dpt:67
#     0     0 ACCEPT     tcp  --  virbr0 *       0.0.0.0/0            0.0.0.0/0            tcp dpt:67
# 
# |*| - Forwarding rules
# 
# Should allow all replies to come back in (packets belonging to RELATED and ESTABLISHED sessions), 
# and allow communications from the virtual network to any other network, as long as the source ip is 
# 192.168.122/24.
#
# FORWARD chain should:
#   ACCEPT forwarding on virbr0 to/fomr subnet range 192.168.122.0/24.
#   REJECT all other traffic.
# 
# Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
#  pkts bytes target     prot opt in     out     source               destination         
#     0     0 ACCEPT     all  --  *      virbr0  0.0.0.0/0            192.168.122.0/24     ctstate RELATED,ESTABLISHED
#     0     0 ACCEPT     all  --  virbr0 *       192.168.122.0/24     0.0.0.0/0           
#     0     0 ACCEPT     all  --  virbr0 virbr0  0.0.0.0/0            0.0.0.0/0           
#     0     0 REJECT     all  --  *      virbr0  0.0.0.0/0            0.0.0.0/0            reject-with icmp-port-unreachable
#     0     0 REJECT     all  --  virbr0 *       0.0.0.0/0            0.0.0.0/0            reject-with icmp-port-unreachable
# 
function vm::iptables-show() {
    sudo iptables -nv
}

# Check ip tables - nat.
function vm::iptables-nat-show() {
    sudo iptables -nvL -t nat
}

# Check ip forwarding.
function vm::ip_forward-show() {
    cat /proc/sys/net/ipv4/ip_forward
}

# Network Bridge ==============================================================
#

[ -z "${LIBVIRT_NETWORK_BRIDGE}" ] && export LIBVIRT_NETWORK_BRIDGE="virbr0"
[ -z "${LIBVIRT_NETWORK_BRIDGE_IFACE}" ] && export LIBVIRT_NETWORK_BRIDGE_IFACE="virbr0-nic"

# List Bridges. 
function vm::network-bridge-list() {
    brctl show
}

# GET bridge.
function vm::network-bridge-get() {
    local name="${1:-${LIBVIRT_NETWORK_BRIDGE}}"
    brctl show "${name}"
}

# CREATE bridge.
function vm::network-bridge-create() {
    local name="${1:-${LIBVIRT_NETWORK_BRIDGE}}"
    brctl addbr "${name}"
}

# DELETE bridge.
function vm::network-bridge-delete() {
    local name="${1:-${LIBVIRT_NETWORK_BRIDGE}}"
    brctl delbr "${name}"
}

# CREATE bridge interface.
function vm::network-bridge-iface-create() {
    # https://serverfault.com/questions/516366/how-virbr0-nic-is-created
    local ifname="${1:-${LIBVIRT_NETWORK_BRIDGE_IFACE}}"
    tunctl -t "${ifname}"
}

# ADD bridge interface.
function vm::network-bridge-iface-add() {
    local ifname="${1:-${LIBVIRT_NETWORK_BRIDGE_IFACE}}"
    local brname="${2:-${LIBVIRT_NETWORK_BRIDGE}}"
    brctl addif "${brname} ${ifname}"
}

# REMOVE bridge interface.
function vm::network-bridge-iface-remove() {
    local ifname="${1:-${LIBVIRT_NETWORK_BRIDGE_IFACE}}"
    local brname="${2:-${LIBVIRT_NETWORK_BRIDGE}}"
    brctl delif "${brname} ${ifname}"
}

# GET dnsmasq info
function vm::network-bridge-iface-remove() {
    sudo cat /var/lib/libvirt/dnsmasq/virbr0.macs
    sudo cat /var/lib/libvirt/dnsmasq/virbr0.status
}

# Storage =====================================================================
#

[ -z "${LIBVIRT_HOME}" ] && export LIBVIRT_HOME="${HOME}/virt-kvm"
[ -z "${LIBVIRT_STORAGE_PATH}" ] && export LIBVIRT_STORAGE_PATH="${LIBVIRT_HOME}/pools"
[ -z "${LIBVIRT_STORAGE_ISO}" ] && export LIBVIRT_STORAGE_ISO="kvm-iso"
[ -z "${LIBVIRT_STORAGE_DEV}" ] && export LIBVIRT_STORAGE_DEV="kvm-dev"

# Pools ------------------------------------------------------------------------
#

# LIST all pools. 
function vm::storage-pool-list() {
    virsh -c qemu:///system pool-list --all
}

# CREATE a pool.
function vm::storage-pool-create() {
    local path=$1
    local name=$2
    mkdir -p "${path}/${name}"
    virsh -c qemu:///system \
        pool-define-as "${name}" \
        dir --target "${path}/${name}"
}

# DELETE a pool.
function vm::storage-pool-delete() {
    local name=$1
    virsh -c qemu:///system pool-delete "${name}"
    virsh -c qemu:///system pool-undefine "${name}"
}

# START a pool
function vm::storage-pool-start() {
    local name=$1
    virsh -c qemu:///system pool-start "${name}"
}

# STOP a pool.
function vm::storage-pool-stop() {
    local name=$1
    virsh -c qemu:///system pool-destroy "${name}"
}

# AUTOSTART a pool.
function vm::storage-pool-autostart() {
    local name=$1
    local autostart=$2
    if [ "${autostart}" == "false" ]; then
        virsh -c qemu:///system pool-autostart "${name}" --disable
    fi
    if [ "${autostart}" == "true" ]; then
        virsh -c qemu:///system pool-autostart "${name}"
    fi    
}

# Volumes ---------------------------------------------------------------------
#

# LIST volume.
function vm::storage-vol-list() {
    local name=$1
    virsh -c qemu:///system vol-list "${name}"
}

# CREATE volume from XML definition.
function vm::storage-vol-create-from-spec() {
    local definition-$1
    local pool_name=$2
    virsh -c qemu:///system vol-list \
        --file "${definition}" \
        --pool "${pool_name}" \
        --prealloc-metadata
}

# CREATE volume from function params.
function vm::storage-vol-create() {
    local pool_name=$1
    local name=$2
    local capacity=${3:-"20GB"}
    local format=${4:-"qcow2"}
    virsh -c qemu:///system \
        vol-create-as "${pool_name}" "${name}" "${capacity}" \
        --format "${format}" \
        --prealloc-metadata
}

# RESIZE volume.
function vm::storage-vol-resize() {
    local pool=$1
    local name=$2
    local capacity=$3
    virsh -c qemu:///system \
        vol-resize "${name}" "${capacity}" \
        --pool "${pool}"
}

# DELETE volume.
function vm::storage-vol-delete() {
    local pool=$1
    local name=$2
    virsh -c qemu:///system \
        vol-delete "${name}" \
        --pool "${pool}"
}


# Images ----------------------------------------------------------------------
#

# DOWNLOAD some isos to the specified directory.
function vm::storage-iso-download() {
    local target="${1:-${LIBVIRT_STORAGE_PATH}/${LIBVIRT_STORAGE_ISO}}"

    pushd "${target}" > /dev/null

    # alpine-standard-3.8.2-x86_64.iso
    if [ ! -f "alpine-standard-3.8.2-x86_64.iso" ]; then
        curl -LO http://dl-cdn.alpinelinux.org/alpine/v3.8/releases/x86_64/alpine-standard-3.8.2-x86_64.iso
    fi  

    # ubuntu-18.10-live-server-amd64.iso
    if [ ! -f "ubuntu-18.10-live-server-amd64.iso" ]; then
        curl -LO http://releases.ubuntu.com/18.10/ubuntu-18.10-live-server-amd64.iso
    fi

    # # ubuntu-18.10-desktop-amd64.iso
    # if [ ! -f "ubuntu-18.10-desktop-amd64.iso" ]; then
    #     curl -LO http://releases.ubuntu.com/18.10/ubuntu-18.10-desktop-amd64.iso
    # fi

    # # CentOS-7-x86_64-DVD-1810.iso
    # if [ ! -f "CentOS-7-x86_64-Minimal-1810.iso" ]; then
    #     curl -LO http://mirror.ox.ac.uk/sites/mirror.centos.org/7.6.1810/isos/x86_64/CentOS-7-x86_64-Minimal-1810.iso
    # fi

    # # CentOS-7-x86_64-DVD-1810.iso
    # if [ ! -f "CentOS-7-x86_64-DVD-1810.iso" ]; then
    #     curl -LO http://mirror.ox.ac.uk/sites/mirror.centos.org/7.6.1810/isos/x86_64/CentOS-7-x86_64-DVD-1810.iso
    # fi

    popd > /dev/null 
}


# Instances (`virt-install`)  =================================================
#

# LIST all system instance.
function vm::compute-instance-list() {
    virsh -c qemu:///system list --all
}

# Install a machine with 'ubuntu18.10 server'.
# Requires 'virt-viewer' to perform the actual install.
# Create a new disk 'on-the-fly' in the specified disk pool: 
# * 'size=20,format=qcow2': 20GB gcow2 disk.
# Needs a restart.
function vm::compute-instance-create() {
    local name=$1
    local nw_name="${2:-default}"

    virt-install -n "${name}" \
        --cpu=host \
        --ram 2048 \
        --vcpus=2 \
        -c "${LIBVIRT_STORAGE_PATH}/${LIBVIRT_STORAGE_ISO}/ubuntu-18.10-live-server-amd64.iso" \
        --os-type=linux \
        --os-variant="ubuntu18.10" \
        --disk=pool="${LIBVIRT_STORAGE_DEV},size=20,format=qcow2" \
        --graphics=vnc \
        -w network="${nw_name}"
}

# START specified instance.
function vm::compute-instance-start() {
    local vm_name=$1
    virsh -c qemu:///system start "${vm_name}"
}

# AUTOSTART specified instance.
function vm::compute-instance-autostart() {
    local vm_name=$1
    local autostart=$2
    if [ "${autostart}" == "false" ]; then
        virsh -c qemu:///system autostart "${name}" --disable
    fi
    if [ "${autostart}" == "true" ]; then
        virsh -c qemu:///system autostart "${name}"
    fi   
}

# Get specified instance spec.
function vm::compute-instance-get() {
    local vm_name=$1
    virsh -c qemu:///system dumpxml "${vm_name}"
}

# SHUTDOWN (soft) specified instance.
function vm::compute-instance-shutdown() {
    local vm_name=$1
    virsh -c qemu:///system shutdown "${vm_name}"
}

# STOP (hard) specified instance.
function vm::compute-instance-stop() {
    local vm_name=$1
    virsh -c qemu:///system destroy "${vm_name}"
}

# Delete specified instance.
function vm::compute-instance-delete() {
    local vm_name=$1
    virsh -c qemu:///system undefine "${vm_name}"
}

# CLONE specified instance to create a new instance.
function vm::compute-instance-clone() {
    local vm_name=$1
    virsh -c qemu:///system --original "${vm_name}" --auto-clone
}

# OPEN a UI based connection to the instance.
function vm::compute-instance-view() {
    local vm_name=$1
    virt-viewer "${vm_name}"
}


# Default =====================================================================
#

[ -z "${VM_DEFAULT_NAME}" ] && export VM_DEFAULT_NAME="cabot"

# Create a default iso pool and populate it with some default images.
function vm::create-iso-pool() {
    vm::storage-pool-create "${LIBVIRT_STORAGE_PATH}" "${LIBVIRT_STORAGE_ISO}"
    vm::storage-pool-start "${LIBVIRT_STORAGE_ISO}"
    vm::storage-pool-autostart "${LIBVIRT_STORAGE_ISO}" true
    vm::storage-iso-download "${LIBVIRT_STORAGE_PATH}/${LIBVIRT_STORAGE_ISO}"

    vm::storage-pool-list
    vm::storage-vol-list "${LIBVIRT_STORAGE_ISO}"
}

# Delete the default iso pool.
function vm::delete-iso-pool() {
    vm::storage-pool-autostart "${LIBVIRT_STORAGE_ISO}" false
    vm::storage-pool-stop "${LIBVIRT_STORAGE_ISO}"
    vm::storage-pool-delete "${LIBVIRT_STORAGE_ISO}"

    vm::storage-pool-list
}

# Create the default device pool.
function vm::create-dev-pool() {
    vm::storage-pool-create "${LIBVIRT_STORAGE_PATH}" "${LIBVIRT_STORAGE_DEV}"
    vm::storage-pool-start "${LIBVIRT_STORAGE_DEV}"
    vm::storage-pool-autostart "${LIBVIRT_STORAGE_DEV}" true
    # vm::storage-vol-create "${LIBVIRT_STORAGE_DEV}" "${VM_DEFAULT_NAME}-01.cow2"

    vm::storage-pool-list
    vm::storage-vol-list "${LIBVIRT_STORAGE_DEV}"
}

# Delete the default device pool 
function vm::delete-dev-pool() {
    vm::storage-vol-delete "${LIBVIRT_STORAGE_DEV}" "${VM_DEFAULT_NAME}-01.cow2"
    vm::storage-pool-autostart "${LIBVIRT_STORAGE_DEV}" false
    vm::storage-pool-stop "${LIBVIRT_STORAGE_DEV}"
    vm::storage-pool-delete "${LIBVIRT_STORAGE_DEV}"

    vm::storage-pool-list
}


# Module ======================================================================
#

function vm::load() {
    [[ "${BASH_SOURCE[0]}" == "${0}" ]] \
        && echo "The 'load' command must be 'sourced' when invoked." && exit 1
    local target="$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)/$(basename ${BASH_SOURCE[0]})"
    alias vm="${target}"
}

function vm::unload() {
    [[ "${BASH_SOURCE[0]}" == "${0}" ]] \
        && echo "The 'unload' command must be 'sourced' when invoked." && exit 1
    unalias vm
    unset -v $(env | grep LIBVIRT | cut -d'=' -f1 | xargs)
    unset -f $(declare -F | grep 'vm::' | awk '{print $NF}' | xargs)
}

function vm::reload() {
    local module="$(alias | grep 'vm=' | cut -d'=' -f2 | xargs)"
    source "${module}" unload
    source "${module}" load
}

if [ ! -z "$1" ]; then
    vm::$*
fi