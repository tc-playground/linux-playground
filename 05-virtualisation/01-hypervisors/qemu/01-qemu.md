# QEMU

## Introduction

* `QEMU` is a generic and open source `machine emulator` and `virtualizer`.

    1. `emulator` - Emulate another processor instruction set, e.g. Run an ARM compiled binary on an x86 architecture.

    2. `virtual machine manager (VMM)` - Run an _isolated_ `virtual machine` on-top of the __host__ operating system and hardware.

* `QEMU` uses a `trap-and execute` process to to trap `OS syscalls` and handle them by `simulating` them, or, `delegating` them the host operating system.

---

## References

* [QEMU](https://www.qemu.org/)