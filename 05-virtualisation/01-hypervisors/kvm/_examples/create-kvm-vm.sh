#!/bin/bash

# kvm =========================================================================
#
# Kernel Virtual Machine - Virtualised Machine
#
# =============================================================================

# Create a home for local ISO images.
export KVM_ISO_HOME="kvm-iso"
function kvm::create-iso-store() {
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
    mkdir -p "${DIR}/${KVM_ISO_HOME}"
}

export KVM_DISK_POOL="kvm-dev"
# Create a home for storage device pools.
function kvm::create-storage-pool() {
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
    mkdir -p "${DIR}/${KVM_DISK_POOL}"
}

# Download iso if they don't exist already.
#
# Glu usecase: If we download an iso, we also want to add it to .gitignore. 
function kvm::download-isos() {
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
    pushd "${DIR}/${KVM_ISO_HOME}" > /dev/null

    # alpine-standard-3.8.2-x86_64.iso
    if [ ! -f "CentOS-7-x86_64-Minimal-1810.iso" ]; then
        curl -LO http://dl-cdn.alpinelinux.org/alpine/v3.8/releases/x86_64/alpine-standard-3.8.2-x86_64.iso
    fi  

    # ubuntu-18.10-live-server-amd64.iso
    if [ ! -f "ubuntu-18.10-live-server-amd64.iso" ]; then
        curl -LO http://releases.ubuntu.com/18.10/ubuntu-18.10-live-server-amd64.iso
    fi
    # ubuntu-18.10-desktop-amd64.iso
    if [ ! -f "ubuntu-18.10-desktop-amd64.iso" ]; then
        curl -LO http://releases.ubuntu.com/18.10/ubuntu-18.10-desktop-amd64.iso
    fi

    # CentOS-7-x86_64-DVD-1810.iso
    if [ ! -f "CentOS-7-x86_64-Minimal-1810.iso" ]; then
        curl -LO http://mirror.ox.ac.uk/sites/mirror.centos.org/7.6.1810/isos/x86_64/CentOS-7-x86_64-Minimal-1810.iso
    fi    
    # CentOS-7-x86_64-DVD-1810.iso
    if [ ! -f "CentOS-7-x86_64-DVD-1810.iso" ]; then
        curl -LO http://mirror.ox.ac.uk/sites/mirror.centos.org/7.6.1810/isos/x86_64/CentOS-7-x86_64-DVD-1810.iso
    fi

    popd > /dev/null
}

# Restart the libvirtd daemon.
function kvm:restart-libvirtd() {
    sudo systemctl restart libvirtd
}

# Open 'virt-manager' UI.
function kvm::open-virt-manager() {
    virt-manager &
}


# Main ========================================================================
#

if [ ! -z "$1" ]; then
    kvm::$*
fi
