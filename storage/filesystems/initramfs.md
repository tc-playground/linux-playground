# `initramfs`

## Introduction

At boot time, the boot loader loads the kernel and the initramfs image into memory and starts the kernel. The kernel checks for the presence of the `initramfs` and, if found, mounts it as `/` and runs `/init`. The `init` program is typically a shell script. 

---

## Overview

* `initramfs` is the solution introduced for the 2.6 Linux kernel series. The idea is that there's a lot of initialisation magic done in the kernel that could be just as easily done in userspace.

* `initramfs` is used as the first root filesystem that your machine has access to. It is used for mounting the real `rootfs` which has all your data.

* `initramfs` carries the modules needed for mounting your `rootfs`.

* `initramfs` boot processes may take longer than those executed in the kernel.

STUB

---

## References

* [Linux from Scratch - `initramfs`](http://www.linuxfromscratch.org/blfs/view/svn/postlfs/initramfs.html)
* [Ubuntu Wiki](https://wiki.ubuntu.com/Initramfs)
* [Wikipedia - Initial Ramdisk](https://en.wikipedia.org/wiki/Initial_ramdisk)