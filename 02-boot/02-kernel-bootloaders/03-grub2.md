# GRUB2

## Introduction

* `GRUB2` (GRand Unified Bootloader 2).

*  `GRUB2` differs from GRUB 1 by having two (optionally three) stages.

* `GRUB 2` is capable of automatic detection of various operating systems and automatic configuration. 

---

## Boot Process

1. `GRUB 2` has a `first-stage loader` is loaded and executed either by the `BIOS`, the `MBR` (Master Boot Record), or, by `another boot loader` from the `PBS` (Partition Boot Sector). 

    1. Its job is to discover and access various file systems that the configuration can be read from later. 
    
4. `GRUB 2` has an optional `intermediate stage loader`. It is loaded and executed by the first-stage loader when:

    1. The `second-stage loader` is not contiguous.
    
    2. The file-system or hardware requires special handling in order to access the second-stage loader. 

5. `GRUB 2` has a `second-stage` loader is loaded last and displays the GRUB startup menu

    1. This allows the user to choose an operating system or examine and edit startup parameters. 
    
    2. After a menu entry is chosen and optional parameters are given, `GRUB 2` loads the kernel into memory and passes control to it. 

6. `GRUB 2` is also capable of `chain-loading` another boot loader.

---

## References

* [Home](https://www.gnu.org/software/grub/)

* [Wikipedia](https://en.wikipedia.org/wiki/GNU_GRUB)

* [GRUB2 Manual](https://www.gnu.org/software/grub/manual/grub/grub.html)

* [GRUB2 Tutorial](https://www.dedoimedo.com/computers/grub.html)

* [GRUB2 Introduction](https://opensource.com/article/17/3/introduction-grub2-configuration-linux)

