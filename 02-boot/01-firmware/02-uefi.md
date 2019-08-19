# UEFI

## Introduction

* `UEFI` is the Unified Extensible Firmware Interface specification.

* `UEFI` is anon-volatile `firmware` used to perform hardware initialization during the booting process (power-on startup).

* `UEFI` provides runtime services for operating systems and programs.

* `UEFI` is superseding `BIOS`.

---

## Linux Startup Process

> Early stages of the Linux startup process depend very much on the computer architecture. 

1. The `UEFI` performs startup tasks specific to the actual hardware platform. 

2. Once the hardware is enumerated and the hardware which is necessary for boot is initialized correctly.

3. The `UEFI` loads and executes the `boot code` from the configured `boot device`.

---

## References

* [Wikipedia - UEFI](https://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface)

* [Wikipedia - Linux Startup Process](https://en.wikipedia.org/wiki/Linux_startup_process)

* [Linux Insides](https://github.com/0xAX/linux-insides)
