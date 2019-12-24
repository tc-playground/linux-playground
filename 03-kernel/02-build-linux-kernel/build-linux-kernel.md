# Building the Linux Kernel.

## Introduction

How to build the Linux kernel!

---

## Overview

1. _Download_ a kernel version archive from: [Linux Kernel Archives](https://www.kernel.org/).

2. _Unpack_ and _validate_ the archive.

3. _Navigate_ to the root of the archive.

4. _Configure_ the kernel (`menuconfig`,`xconfig`,`gconfig`).

5. _Build_ the kernel.

6. _Install_ the kernel modules and the kernel.


---

## Configuration

* The output kernel binary is dependent on the configuration file `./config` found at the root of the source.

* Default configurations can be found at `/boot/config-$(uname -r) .config`.

* The configuration can be edited using the `menuconfig` tool.


---

## Tutorials

* [Building the Kernel](https://www.cyberciti.biz/tips/compiling-linux-kernel-26.html)

* [Building the Kernel - Stack Exchange](https://unix.stackexchange.com/questions/115620/configuring-compiling-and-installing-a-custom-linux-kernel)

---

## References

* [Kernel Download - kernel.org](https://www.kernel.org/)