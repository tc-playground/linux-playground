# Loading Microcode

## Introduction

* `microcode` a low-level `instruction set` which is `stored permanently` in a device and `controls the operation of the device`.

* `microcode` is a `low level hardware instructions` that serves as the basis of `programmable` instruction set.

* `microcode` is a layer of `hardware-level instructions` that implement higher-level `machine code instructions`.

* `microcode` typically resides in `special high-speed memory` and `translates machine instructions`, `state machine data` or other input into `sequences of detailed circuit-level operations`.

* `microcode` is a `computer hardware technique` that interposes a `layer of organisation` between the `CPU hardware` and the `programmer-visible instruction set architecture` of the computer.

* `microcode` can be loaded at `boot time` to fix `CPU issues` and `vulnerabilities`.

* `linux kernel` has a `x86 microcode loading facility` which provides microcode loading methods in the OS.

---

## Linux Kernel Microcode Loading

### Early load microcode

* The kernel can update microcode very early during boot. 

    > NB: Loading microcode early can fix CPU issues before they are observed during kernel boot time.

* The `microcode` is stored in an `initrd file`. During `boot`, it is read from it and `loaded into the CPU cores`.

* The format of the combined `initrd image` is microcode in (uncompressed) `cpio format` followed by the (possibly compressed) `initrd image`. 

* The `loader parses` the combined `initrd image` during `boot`.

* The `microcode files` in `cpio` name space are:

    * __Intel__: `kernel/x86/microcode/GenuineIntel.bin`

    * __AMD__  : `kernel/x86/microcode/AuthenticAMD.bin`

* During `BSP` (BootStrapping Processor) boot (`pre-SMP`), the kernel scans the `microcode` file in the `initrd`. 

* If `microcode` matching the CPU is found, it will be applied in the `BSP` and later on in all `AP`s (Application Processors).


### Late loading microcode

* There are two legacy `user space` interfaces to load microcode: 

    * `/dev/cpu/microcode`
    
    * `/sys/devices/system/cpu/microcode/reload` file in `sysfs`.

### Builtin microcode

* The `microcode loader` also supports loading of a `builtin microcode` supplied through the regular builtin firmware method `CONFIG_EXTRA_FIRMWARE`.

---

## References

* [Wikipedia - Microcode](https://en.wikipedia.org/wiki/Microcode)

* [Linux Kernel Docs](https://www.kernel.org/doc/html/latest/x86/microcode.html)

