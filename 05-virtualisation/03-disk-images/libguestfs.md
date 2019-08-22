# libguestfs

---

## Introduction

 * __libguestfs__ is a set of tools for accessing and modifying virtual machine (VM) disk images. It can be used for viewing and editing files inside guests, scripting changes to VMs, monitoring disk used/free statistics, creating guests, P2V, V2V, performing backups, cloning VMs, building VMs, formatting disks, resizing disks, and much more.

* __libguestfs__ can access almost any disk image imaginable. It can do it securely — without needing root and with multiple layers of defence against rogue disk images. It can access disk images on remote machines or on CDs/USB sticks. It can access proprietary systems like VMware and Hyper-V.

All this functionality is available through a scriptable shell called __guestfish__, or an interactive rescue shell __virt-rescue__.

* __libguestfs__ is a C library that can be linked with C and C++ management programs and has bindings for about a dozen other programming languages. Using our FUSE module you can also mount guest filesystems on the host.

---

## guestfish

* __guestfish__ is a shell and command-line tool for examining and modifying virtual machine filesystems. It uses `libguestfs` and exposes all of the functionality of the guestfs API, see `guestfs(3)`.

* __guestfish__ gives you structured access to the libguestfs API, from shell scripts or the command line or interactively. If you want to rescue a broken virtual machine image, you should look at the `virt-rescue(1)` command.


---

## virt-rescue

* __virt-rescue__ is like a Rescue CD, but for virtual machines, and without the need for a CD. virt-rescue gives you a rescue shell and some simple recovery tools which you can use to examine or rescue a virtual machine or disk image.

---

## References

* [Wikipedia](https://en.wikipedia.org/wiki/Libguestfs)

* [Home](http://libguestfs.org/)

* [Github](https://github.com/libguestfs/libguestfs)

* [Manual](http://libguestfs.org/guestfs.3.html)

* [guestfish](http://libguestfs.org/guestfish.1.html)

* [virt-rescue](http://libguestfs.org/virt-rescue.1.html)
