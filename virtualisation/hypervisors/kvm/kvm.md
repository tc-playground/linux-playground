# KVM (Kernel Virtual Machine)

---

## Introduction

KVM, kernel-based virtual machine. __KVM__ is a type 2 hypervisor, which means it runs on a host operating system. __VirtualBox__ and __Hyper-V__ are type 2 hypervisors. In contrast, type 1 hypervisors run on the bare metal and don't need host operating systems, like __Xen__ and __VMware ESX__.

---

## Components

* [KVM](https://www.linux-kvm.org/page/Main_Page) - KVM itself is a kernel module that must be installed and loaded into the kernel.

* [QEMU (or other VMM)](https://www.qemu.org/) - Can be used provide suer-level KVM (qemu-kvm) and disk image (qemu-img) management functionality.

* [libvirt](https://libvirt.org/) - Is a toolkit to manage virtualization platforms KVM, QEMU, Xen, Virtuozzo, VMWare ESX, LXC, BHyve and more. The core consists of the `libvirt` library, `libvirtd` server daemon, and, `virsh` client command tool.

---

## References
* [KVM Home](http://www.linux-kvm.org/page/Main_Page)
* [KVM Docs](http://www.linux-kvm.org/page/Documents)
* [virsh cheatsheet](https://help.ubuntu.com/community/KVM/Virsh)
* [Red Hat Virtualisation Guide](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/)
