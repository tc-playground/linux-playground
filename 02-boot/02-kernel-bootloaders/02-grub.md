# GRUB

## Introduction

* `GRUB` (GRand Unified Bootloader).

* `GRUB` can read common filesystems, so, can change the configuration at runtime before booting.

* `GRUB` is `legacy` and has been replaced by `GRUB2`.

---

## Boot Process

1. `GRUB` includes logic to read common file systems at run-time in order to access its configuration file.

2. `GRUB` therefore has the ability to read its configuration file from the filesystem rather than have it embedded into the `MBR`. 

3. `GRUB` therefore can change the configuration at run-time and specify disks and partitions in a human-readable format rather than relying on offsets. 

4. `GRUB` also contains a command-line interface, which makes it easier to fix or modify GRUB if it is misconfigured or corrupt.

---

## References

* [Home](https://www.gnu.org/software/grub/)

* [Wikipedia](https://en.wikipedia.org/wiki/GNU_GRUB)


