# virt-manager Tools

---

## Introduction

A collection of tools for dealing with VM management via `libvirt`. Python based.

---

## Tools

### UI Tools

* __virt-manager__ -  A desktop user interface for managing virtual machines through libvirt. It primarily targets KVM VMs, but also manages Xen and LXC (linux containers). It presents a summary view of running domains, their live performance & resource utilization statistics. Wizards enable the creation of new domains, and configuration & adjustment of a domain’s resource allocation & virtual hardware. An embedded VNC and SPICE client viewer presents a full graphical console to the guest domain.

* __virt-viewer__ -  A lightweight UI interface for interacting with the graphical display of virtualized guest OS. It can display VNC or SPICE, and uses libvirt to lookup the graphical connection details.

### CLI Tools

* __virt-install__ - A command line tool which provides an easy way to provision operating systems into virtual machines.

* __virt-clone__ - A command line tool for cloning existing inactive guests. It copies the disk images, and defines a config with new name, UUID and MAC address pointing to the copied disks.

* __virt-xml__ - A command line tool for easily editing libvirt domain XML using `virt-install`’s command line options.

* __virt-convert__ - A command line tool for converting OVF and VMX VM configurations to run with libvirt.

* __virt-bootstrap__ - A command tool providing an easy way to setup the root file system for libvirt-based containers. 

---

## References

* [virt-manager Home](https://virt-manager.org/)
* [virt-manager Github](https://github.com/virt-manager)
* [virt-bootstrap Github](https://github.com/virt-manager/virt-bootstrap)