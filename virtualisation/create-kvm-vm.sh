#!/bin/bash

# kvm =========================================================================
#
# Kernel Virtual Machine - Virtualised Machine
#
# =============================================================================

# Check Intel hardware virtualisation is installed...
function kvm::check-intel-hw-virtualisation-enabled() {
    local res=$(grep -e 'vmx' /proc/cpuinfo | grep flag | wc -l)
    if [ "${res}" == 0 ]; then
        echo "Failure: Intel VMX hardware extension not enabled."
    else
        echo "Success: Intel VMX hardware extension is enabled."
    fi
}

# Check AMD hardware virualisation is installed...
function kvm::check-amd-hw-virtualisation-enabled() {
    local res=$(grep -e 'svm' /proc/cpuinfo | grep flag | wc -l)
    if [ "${res}" == "0" ]; then
        echo "Failure: AMD SVM hardware extension not enabled."
    else 
        echo "Success: AMD SVM hardware extension is enabled."
    fi
}

# Check KVM kernel module is installed...
function kvm::check-kvm-kernel-mod-loaded() {
    local res=$(lsmod | grep kvm)
    if [ -z "${res}" ]; then
        echo "Failure: KVM kernel module not loaded."
    else
       echo "Success: KVM kernel module is loaded."     
    fi
}

# Apt install KVM and Virt.
function kvm::kvm-apt-install() {
    sudo apt install -y qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virt-manager cpu-checker
}

# Ensure user is member of 'kvn' and 'libvirtd' groups.
function kvm::ensure-user-groups() {
    sudo adduser $(id -un) kvm
    sudo adduser $(id -un) libvirtd
}

function kvm::check() {
    echo
    printf "\u001b[32m"
    printf "#1 - Testing KVM:\n"
    printf "\u001b[0m"
    echo
    kvm-ok

    echo
    printf "\u001b[32m"
    echo "#3 - Check '/dev/kvm':"
    printf "\u001b[0m"
    echo
    sudo ls -l /dev/kvm
    echo

    echo
    printf "\u001b[32m"
    echo "#2 - Testing VM List:"
    printf "\u001b[0m"
    echo
    virsh list --all
    echo

    echo
    printf "\u001b[32m"
    echo "#4 - Check 'libvirt-sock':"
    printf "\u001b[0m"
    echo
    sudo ls -la /var/run/libvirt/libvirt-sock
    echo

    echo
    printf "\u001b[32m"
    echo "#5 - Check 'libvertd' status:"
    printf "\u001b[0m"
    echo
    sudo systemctl status libvirtd  -l --no-pager
    echo
}


# Create a home for local ISO images.
ISO_HOME="kvm-iso"
function kvm::create-iso-store() {
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
    mkdir -p "${DIR}/${ISO_HOME}"
}

DISK_POOL="kvm-pool"
# Create a home for storage device pools.
function kvm::create-storage-pool() {
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
    mkdir -p "${DIR}/${DISK_POOL}"
}

# Download iso if they don't exist already.
#
# Glu usecase: If we download an iso, we also want to add it to .gitignore. 
function kvm::download-isos() {
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
    pushd "${DIR}/${ISO_HOME}" > /dev/null

    
    # alpine-standard-3.8.2-x86_64.iso
    if [ ! -f "CentOS-7-x86_64-Minimal-1810.iso" ]; then
        curl -LO http://dl-cdn.alpinelinux.org/alpine/v3.8/releases/x86_64/alpine-standard-3.8.2-x86_64.iso
    fi  

    # CentOS-7-x86_64-DVD-1810.iso
    if [ ! -f "CentOS-7-x86_64-Minimal-1810.iso" ]; then
        curl -LO http://mirror.ox.ac.uk/sites/mirror.centos.org/7.6.1810/isos/x86_64/CentOS-7-x86_64-Minimal-1810.iso
    fi    
    # CentOS-7-x86_64-DVD-1810.iso
    if [ ! -f "CentOS-7-x86_64-DVD-1810.iso" ]; then
        curl -LO http://mirror.ox.ac.uk/sites/mirror.centos.org/7.6.1810/isos/x86_64/CentOS-7-x86_64-DVD-1810.iso
    fi

    # ubuntu-18.10-live-server-amd64.iso
    if [ ! -f "ubuntu-18.10-live-server-amd64.iso" ]; then
        curl -LO http://releases.ubuntu.com/18.10/ubuntu-18.10-live-server-amd64.iso
    fi
    # ubuntu-18.10-desktop-amd64.iso
    if [ ! -f "ubuntu-18.10-desktop-amd64.iso" ]; then
        curl -LO http://releases.ubuntu.com/18.10/ubuntu-18.10-desktop-amd64.iso
    fi

    popd > /dev/null 
}


# Open 'virt-manager' UI.
function kvm::open-virt-manager() {
    virt-manager &
}


if [ ! -z "$1" ]; then
    kvm::$*
fi
