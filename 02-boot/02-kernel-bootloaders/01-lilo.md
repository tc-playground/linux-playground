# LILO (Linux Loader)

## Introduction

* `LILO` generates a config file (base don offsets) and writes it to the `MBR` to boot the system.

---

## Boot Process

1. `LILO` does not understand or parse filesystem layout. Instead, a `configuration file` (/etc/lilo.conf) is created in a live system which maps raw offset information (from a `mapper tool`) about location of `kernel` and `ram disks` (initrd or initramfs). 

2. The `LILO` configuration file, which includes the `boot partition` and `kernel pathname`, and, `customized options`, is then written together with `bootloader` code into `MBR bootsector`. 

3. When the `MBR bootsector` is read and given control by BIOS, `LILO` loads the menu code and draws it then uses stored values together with user input to calculate and load the Linux kernel or chain-load any other boot-loader.


---

## References

* [Wikipedia](https://en.wikipedia.org/wiki/LILO_(boot_loader))




