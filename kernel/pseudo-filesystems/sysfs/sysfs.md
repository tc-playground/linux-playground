# The Linux 'sys' Filesystem

## Introduction

`sysfs` is a pseudo file system provided by the Linux kernel that exports information about various kernel subsystems, hardware devices, and associated device drivers from the kernel's device model to user space through `virtual files`. In addition to providing information about various devices and kernel subsystems, exported virtual files are also used for their configuration.

`sysfs` provides functionality similar to the `sysctl` mechanism found in BSD operating systems, with the difference that `sysfs` is implemented as a `virtual file system` instead of being a purpose-built kernel mechanism, 

> NB: `sysctl` configuration parameters are made available at `/proc/sys/` as part of `procfs`, not `sysfs` which is mounted at `/sys`.

---

## Linux `/sys` Overview

### Linux `/sys`

* `/sys/block` - A _directory_ containing one symbolic link for each `block device` that has been discovered on the system. The symbolic links point to corresponding directories under `/sys/devices`.

* `/sys/bus` - A _directory_ containing one subdirectory for each of the `bus types` in the kernel.

    * `devices` - This subdirectory contains symbolic links to entries in `/sys/devices` that correspond to the devices discovered on this bus.

    * `drivers` - This subdirectory contains one subdirectory for each device driver that is loaded on this bus.

* `/sys/class` - A _directory_ containing a subdirectory for each of the `device classes` (`terminals`, `network devices`, `block devices`, `graphics devices`, `sound devices`, etc) registered. Inside each of these are symbolic links for each of the devices of this class. These symbolic links refer to entries in the `/sys/devices` directory.

    * `net` - A _directory_ containing a _symbolic link to a subdirectory for each `network interface` (physical and virtual) in the system. These symbolic links refer to entries in the `/sys/devices` directory.

* `/sys/dev` - A _directory_ containing two subdirectories `block` and `char` for the `block devices` and `character devices` on the system. Each device on the system is represented by a symbolic link of the form `major-id:minor-id`  of the device. Each link point to the specific device in `/sys/devices`.

* `/sys/devices` - A _directory_ that contains a `filesystem` representation of the `kernel device tree`, which is a hierarchy of device structures within the kernel. These devices are referenced by symbolic links from other parts of `procfs`.

* `/sys/firmware` -A _directory_ that contains interfaces for viewing and manipulating `firmware-specific objects and attributes`.

* `/sys/fs` - A _directory_ that contains subdirectories for some `filesystems`. A `filesystem` will have a subdirectory here only if it chose to explicitly create the subdirectory.

    * `cgroup` - A _directory_ that conventionally is used as a `mount point` for a `tmpfs(5)` filesystem containing mount points for `cgroups(7)` filesystems.

    * `smackfs` - A _directory_ that contains configuration files for the `SMACK LSM`. SMACK is a linux security module.

* `/sys/hypervisor` - TODO.

* `/sys/kernel` - A _directory_ that contains various files and subdirectories that provide information about the running kernel.

    * `cgroup` - For information about the files in this directory, see `cgroup(7)`.

    * `debug/tracing` - Mount point for the `tracefs filesystem` used by the kernel's `ftrace` facility. (For information on `ftrace`, see the kernel source file Documentation/trace/ftrace.txt.)
    
    * `/sys/kernel/mm` - This subdirectory contains various files and subdirectories that provide information about the kernel's memory management subsystem.

    * `/sys/kernel/mm/hugepages` - This  subdirectory  contains  one  subdirectory  for each of the huge page sizes that the system supports.

* `/sys/module` - This  subdirectory  contains  one subdirectory for each module that is loaded into the kernel.  The name of each directory is the name of the module.

* `/sys/power` - TODO.



### Linux `/sys/class/net`

 Each of the entries in this directory is a symbolic link representing one of the `real or virtual networking devices` that are visible in the network namespace of the process that is accessing the directory. Each of these symbolic links refers to entries in the `/sys/devices` directory. for example:

 ```
lrwxrwxrwx 1 root root 0 Jan  1 12:01 docker0 -> ../../devices/virtual/net/docker0
lrwxrwxrwx 1 root root 0 Jan  1 12:01 lo -> ../../devices/virtual/net/lo
lrwxrwxrwx 1 root root 0 Jan  1 12:01 wlp6s0 -> ../../devices/pci0000:00/0000:00:1c.2/0000:06:00.0/net/wlp6s0
 ```



---

## References

* [Wikipedia](https://en.wikipedia.org/wiki/Sysfs)
* [Man page 5](http://man7.org/linux/man-pages/man5/sysfs.5.html)
