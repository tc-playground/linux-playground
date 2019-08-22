# libvirtd

---

## Introduction

__libvirtd__ takes care of managing the VMs running on your host. It is the (systemd) daemon that starts them up, stops them and prepares the environment that they need. 

libvirtd cna be interacted with in various ways: 

* The `virsh` command from the shell

* The `virt-manager` program provides a graphical interface via `virt-viewer`. 

* The __virt-tools__ from `virt-manager` project provide additional command line tools: `virt-install`, `virt-clone`, `virt-xml`, `virt-convert_`, etc.

* If installed as a `systemd` service, the daemon itself can be managed using `systemctl`.

---

## Notes

* __libvirtd unix domain sockets__ - `/var/run/libvirt`

* __libvirtd config__ - `/etc/libvirt/libvirtd.conf`

* __libvirtd example urls__
    * __Remote Xen__ - `xen+ssh://root@myserver.com/`
    * __qemu system__ - `qemu:///system`
    * __qemu session__ - `qemu:///session`

---

## References

* [libvirt](https://libvirt.org/)
* [man page](https://www.systutorials.com/docs/linux/man/8-libvirtd/)
* [man page 2](https://linux.die.net/man/8/libvirtd)