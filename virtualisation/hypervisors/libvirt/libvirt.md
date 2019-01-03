# libvirt

---

## Introduction

[libvirt](https://libvirt.org/) - Is a toolkit to manage virtualization platforms KVM, QEMU, Xen, Virtuozzo, VMWare ESX, LXC, BHyve and more.

---

## Components

`libvirt` is composed of various binaries and tools. These are provided a different levels of abstraction. For example, `virsh` provides fine-grained access to `libvirtd`, where as `virt-install` creates a new VM in a single command.

* [libvirtd](https://linux.die.net/man/8/libvirtd) - The `libvirtd` program is a server side (`systemd`) daemon component of the libvirt virtualization management system.

* [virsh](https://libvirt.org/virshcmdref.html) - The `virsh` program is client side utility for interacting with the `libvirtd` daemon. 
    
* [virsh bindings](https://libvirt.org/bindings.html) - There are various language bindings available. 
    
* [virt-manager](https://virt-manager.org/) - UI and command-line tools for managing environments.
    * __UI__ : `virt-manager` and `virt-viewer`.
    * __Commands__ : `virt-install`, `virt-clone`, `virt-xml`, `virt-convert`, `virt-bootstrap`.

* [dnsmasque](http://www.thekelleys.org.uk/dnsmasq/doc.html) - For networking utilities DNS, DHCP, NAT, etc. `libvirt` starts `dnsmasq`, which is a simple DHCP server with the ability to also provide DNS names. 


> NB: Other [libvirt management tools](https://libvirt.org/apps.html) - A list of support tools.


---

## Resources

Each object in `libvirt`, being it a network, a pool of disks to use, or a VM, __is defined by an xml file__.

### Network

### Storage


---

## Tutorials

* [Getting Started](http://rabexc.org/posts/how-to-get-started-with-libvirt-on)

---

## References

* [Home](https://libvirt.org/)
* [Wiki](https://wiki.libvirt.org/page/Main_Page)
* [Terminology](https://libvirt.org/goals.html)
* [VM life-cycle](https://wiki.libvirt.org/page/VM_lifecycle)
* [Storage](https://libvirt.org/storage.html)
* [Networking](https://wiki.libvirt.org/page/VirtualNetworking)
    * [NAT - Red Hat Docs](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/chap-Network_configuration#sect-Network_configuration-Network_Address_Translation_NAT_with_libvirt)
    * [Bridged Network - Red Hat Docs](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/sect-Network_configuration-Bridged_networking#sect-Network_configuration-Bridged_networking_in_RHEL)
* [Domain XML Format](https://libvirt.org/formatdomain.html)
* [Drivers](https://libvirt.org/drivers.html)
* [Library Architecture](https://www.ibm.com/developerworks/linux/library/l-libvirt/)

