# BIOS

## Introduction

* `BIOS` is the Basic Input Output System of a computer system.

* `BIOS` is a non-volatile `firmware` used to perform hardware initialization during the booting process (power-on startup).

* `BIOS` provides runtime services for operating systems and programs.

* `BIOS` is being superseded by `UEFI`.

---

## Linux Startup Process

> Early stages of the Linux startup process depend very much on the computer architecture. 

1. The `BIOS` performs startup tasks specific to the actual hardware platform. 

2. Once the hardware is enumerated and the hardware which is necessary for boot is initialized correctly.

3. The `BIOS` loads and executes the `boot code` from the configured `boot device`.

---

## References

* [Wikipedia - BIOS](https://en.wikipedia.org/wiki/BIOS)

* [Wikipedia - Linux Startup Process](https://en.wikipedia.org/wiki/Linux_startup_process)

* [Linux Insides](https://github.com/0xAX/linux-insides)
