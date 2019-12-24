# udev

## Introduction

`udev` (userspace `/dev`) is a device manager for the Linux kernel. `udev` primarily manages device nodes in the `/dev` directory. At the same time, `udev` also handles all _user space events_ raised when hardware devices are added into the system or removed from it. `udev`:

* Runs in _user space_ via `udevd`.

* Creates _persistent device names_, by taking the device naming out of kernel space and implementing rule based device naming.

* Creates a dynamic `/dev` pseudo filesystem with device nodes for devices present in the system and allocates unused major/minor device numbers dynamically.

* Provides a user space API to access the device information in the system.

---

## Notes

* `udev` depends on the `sysfs` file system. When a device is added or removed, _kernel events_ are produced which will notify `udev` in user space.

* `udev` provides a persistent device naming system through the `/dev` directory, making it easier to identify the device. It does this by mapping the major/minor number device pairs to `/dev`. __NB__: All character and block devices have a fixed major/minor number pair assigned to them. The authority responsible for assigning the major/minor pair is the _Linux Assigned Name and Number Authority_. `udev` make better use of these by managing unused pairs.

* `udev` is supported in user space by the `udevd` daemon. `udevd` listens to the _netlink socket_ that the kernel uses for communicating with user space applications. The kernel sends events to the netlink socket when a device is added, or removed from a system. `udevd` handles these events: device node creation, module loading etc.

* `udev` maps discovered devices to `/dev` via _udev rules_.

* `udevadm` is a tool that can be used to create and manage udev rules.

* `udev` help support _hot-plugging_ (inserting devices into a running system) by a combination of three components: `Udev`, `HAL`, and `Dbus`.

* `udev` replaces the following older mechanism: `devfsd` and `hotplug`, 

---

## Tutorials


* [Introduction to device management](https://www.linux.com/news/udev-introduction-device-management-modern-linux-system)

---

## References

* [Wikipedia](https://en.wikipedia.org/wiki/Udev)
* [Home](https://www.freedesktop.org/wiki/Software/systemd/)
* [Repo](https://github.com/systemd/systemd)
