# Create KVM Linux VM

## Introduction

Simple example functions for helping install KVM, libvirtd, and, virt-manager.

## Usage

A new virtual machine can then be created using the virt-manager UI. Use the following command via the `./create-kvm-vm.sh` script.

1. Check KVM is installable:
    1. Check HW virtualisation is enable: `check-intel-hw-virtualisation-enabled`
    2. Check KVM kernel modules is loaded: `check-kvm-kernel-mod-loaded`
2. Install KVM (via apt): `kvm-apt-install`
3. Check installation: `check`
4. Create home directories for images and virtual disk storage pools: 
    1. kvm-iso: `create-iso-store`
    2. kvm-pool: `create-storage-pool`
5. Download the OS iso images: `download-isos`
6. Create Virtual Machine manually via 'virt-manager':
    1. Run `virt-manager`
    2. Create an 'iso' storage pool that references local isos.
    3. Create a 'disk' storage pool and create one or more virtual disks.
    4. Create a new virtual machine.
        1. Select iso.
        2. Select disk.
        3. Define networking.
        4. Follow install instructions.


## References

### Ubuntu Installation
* [Ubuntu KVM Installtion](https://help.ubuntu.com/community/KVM/Installation)
* [NixCraft Guide](https://www.cyberciti.biz/faq/installing-kvm-on-ubuntu-16-04-lts-server/)

### Tutorial
* [Linux.com Tutorial 1](https://www.linux.com/learn/intro-to-linux/2017/5/creating-virtual-machines-kvm-part-1)
* [Linux.com Tutorial 2](https://www.linux.com/learn/intro-to-linux/2017/5/creating-virtual-machines-kvm-part-2-networking)

### RHEL, CentOS, OEL Tutorial
* [Installation](https://www.tecmint.com/install-and-configure-kvm-in-linux/)
* [Networking](https://www.tecmint.com/multiple-virtual-machine-installation-using-network-install-kvm/)
* [Storage Volumes and Pools](https://www.tecmint.com/manage-kvm-storage-volumes-and-pools/)
* [Management Tools](https://www.tecmint.com/kvm-management-tools-to-manage-virtual-machines/)