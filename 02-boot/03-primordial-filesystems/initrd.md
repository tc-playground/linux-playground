# `initrd` - Initial RAM Disk.

## Introduction

- `initrd` is the `initial ramdisk`.

- `initrd` is a scheme for loading a `temporary root file system` into `memory`, as part of the `Linux startup process`.

- `initrd` is an `initial root file system` that is `mounted` prior to when the `real root file system` is available.

- `initrd` is used to make `preparations`such as loading `hardware kernel modules` before the `real root file system` can be `mounted`.

- `initrd` and `initramfs` refer to two different methods of achieving this.

---

## `initrd`

- The `linux kernel` is shipped as a `generic image` with no specific hardware `device drivers`.

- The required `device drivers` for the `generic kernel` are then loaded as `loadable kernel modules`.

- `initrd` is a temporary filesystem that can be used to discover and load the required `device driver modules`.

- `initrd` can be used to handle preparations for `encryption`, `LVM`, `RAID`, `NFS`, `hibernation`, etc. when booting the `real root file system`.

- Sometimes referred to as `early user space`.

---

## References

- [Linux Kernel Docs](https://www.kernel.org/doc/html/latest/admin-guide/initrd.html)

- [Wikipedia](https://en.wikipedia.org/wiki/Initial_ramdisk)

- [IBM Development Series](https://developer.ibm.com/articles/l-initrd/)
