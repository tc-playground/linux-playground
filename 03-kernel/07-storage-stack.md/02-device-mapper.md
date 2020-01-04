# Device Mapper

## Introduction

1. The `device mapper` is a framework provided by the Linux kernel for mapping __physical block devices__ onto higher-level __virtual block devices__.

2. The `device mapper` forms the foundation of:

    1. The `Logical Volume Manager (LVM)`.
    
    2. `Software RAID`.
    
    3. `dm-crypt` disk encryption.
    
    4. Additional Filesystem features: ` snapshots`, `caching`, `striping`, `mirroring`, `event simulation`, etc.

3. The `device mapper` allows the kernel to inspect and process data flowing though it.

    * e.g. perform `encryption / decryption`, route data for a `virtual device` to a `physical device`.

4. `dmsetup` is a command line utility that allows the device mapper and it's configuration to be inspected.

5. To use `device mapper`, install the userspace configuration tool (`dmsetup`) and library (`libdevmapper`). 

---

## Operation

1. New mapped devices can be created for device mapper via the `libdevmapper.so` shared library.

2. `libdevmapper.so` in turn issues `ioctl` system calls to the `/dev/mapper/control` `device node`.

    1. `ioctl (Input/Output Control)` is a __system call__ for device-specific input/output operations.

        * Also, other operations which cannot be expressed by regular system calls.
    
    2. `Devices nodes` are an interface to a `device driver` that appears in a `file system` as if it were an ordinary `file`. 

---

## Application

1. [LVM2](https://en.wikipedia.org/wiki/Logical_volume_management) - logical volume manager for the Linux kernel.

2. RAID - Simulate RAID devices. `dm-raid`.

2. [LUKS](https://en.wikipedia.org/wiki/Linux_Unified_Key_Setup) - Apply encryption .decryption. `cryptsetup`, `dm-crypt`.

3. [Docker](https://en.wikipedia.org/wiki/Docker_(software)) - uses device mapper to create copy-on-write storage for software containers.

---

## `dmsetup` Examples

1. To list the device mapper devices: `sudo dmsetup ls`

2. To get information about any DM device: `sudo dmsetup info /dev/VG00/LV00`

4. To get the status of a DM device: `sudo dmsetup status /dev/VG00/LV00` 

5. To list the DM device dependencies: `sudo dmsetup deps /dev/VG00/LV00`

> Other command verbs include: `clear`, `remove`, `suspend`, `resume`, etc.

> Other operations include: send message, rename, get table info, etc.

---

## Resources

* [Device Mapper - Wikipedia](https://en.wikipedia.org/wiki/Device_mapper)

* [Device Mapper - Home Page](https://sourceware.org/dm/)

* [dmsetup - CLI tool](https://linux.die.net/man/8/dmsetup)

    * [dmsetup - Examples](http://linuxadministrative.blogspot.com/2014/06/dmsetup-command-examples.html)

* [ioctl - system call](https://en.wikipedia.org/wiki/Ioctl)

* [Device Nodes](https://en.wikipedia.org/wiki/Device_file)

* [Device Mapper Multipathing](https://www.thegeekdiary.com/beginners-guide-to-device-mapper-dm-multipathing/)