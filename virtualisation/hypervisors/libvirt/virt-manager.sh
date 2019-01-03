#!/bin/bash

function create-vm-ubuntu-server() {
    local domain=$1
    local disk="ubuntu-server-02.qcow2"
    local ubuntu_server_iso="ubuntu-18.10-live-server-amd64.iso"
    local os_variation="ubuntu18.10"
    
    local dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
    local storage_path="${dir}/kvm-storage"
    local iso_path="${dir}/kvm-iso"

    virt-install \
             --connect qemu:///system \
             --virt-type kvm \
             --name "${domain}" \
             --ram 512 \
             --disk path="${storage_path}/${disk}",size=8 \
             --vnc \
             --cdrom "${iso_path}/${ubuntu_server_iso}" \
             --network network=default,mac=52:54:00:9c:94:3b \
             --os-variant fedora14
}

# List all the os variation defined names.
function list-os-variations() {
    osinfo-query os
}

