#!/bin/bash


[ -z "${LIBVIRT_URL}" ] && export LIBVIRT_URL="qemu:///system"



# Networking ==================================================================
#
# * https://libvirt.org/formatnetwork.html
#

[ -z "${LIBVIRT_NETWORK_BRIDGE}" ] && export LIBVIRT_NETWORK_BRIDGE="virbr0"
[ -z "${LIBVIRT_NETWORK_NAME}" ] && export LIBVIRT_NETWORK_NAME="default"
[ -z "${LIBVIRT_NETWORK_SPEC}" ] && export LIBVIRT_NETWORK_SPEC="${PWD}/network.xml"

# LIST virtual networks. [net-list]
function virsh::network-list() {
    local url="${1:-${LIBVIRT_URL}}"
    virsh -c "${url}" net-list --all
}

# GET the named network. [net-dump]
function virsh::network-get() {
    local name="${1:-${LIBVIRT_NETWORK_NAME}}"
    local url="${2:-${LIBVIRT_URL}}"
    virsh -c "${url}" net-dumpxml "${name}"
}

# EDIT the named network. [net-edit]
function virsh::network-edit() {
    local name="${1:-${LIBVIRT_NETWORK_NAME}}"
    local url="${2:-${LIBVIRT_URL}}"
    virsh -c "${url}" net-edit "${name}"
}

# CREATE a named network. [net-define]
function virsh::network-create() {
    local nw_spec="${1:-${LIBVIRT_NETWORK_SPEC}}"
    local url="${2:-${LIBVIRT_URL}}"
    virsh -c "${url}" net-define "${nw_spec}"
}

# DELETE a named network. [net-undefine]
function virsh::network-delete() {
    local name="${1:-${LIBVIRT_NETWORK_NAME}}"
    local url="${2:-${LIBVIRT_URL}}"
    virsh -c "${url}" net-undefine "${name}"
}

# START a named network. [net-start]
function virsh::network-start() {
    local name="${1:-${LIBVIRT_NETWORK_NAME}}"
    local url="${2:-${LIBVIRT_URL}}"
    virsh -c "${url}" net-start "${name}" > /dev/null
    if [ $? == 0 ]; then
        echo "Network default started"
    fi
}

# STOP a named network. [net-destroy]
function virsh::network-stop() {
    local name="${1:-${LIBVIRT_NETWORK_NAME}}"
    local url="${2:-${LIBVIRT_URL}}"
    virsh -c "${url}" net-destroy "${name}" > /dev/null
    if [ $? == 0 ]; then
        echo "Network default stopped"
    fi
}

# AUTOSTART a named network on boot. [net-autostart]
function virsh::network-autostart() {
    local name="${1:-${LIBVIRT_NETWORK_NAME}}"
    local url="${2:-${LIBVIRT_URL}}"
    virsh -c "${url}" net-autostart "${name}"
}

# Generate a network definition template.
# TODO - Add function to create new bridge.
function virsh::network-generate-network-spec() {
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


# Miscellaneous ===============================================================
#

# Help for 'virsh' tool.
function  virsh::help() {
    man virsh
}

if [ ! -z "$1" ]; then
    virsh::$*
fi