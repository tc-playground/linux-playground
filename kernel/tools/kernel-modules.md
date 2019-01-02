# Linux Kernel Modules

---

## Introduction

Linux kernel modules are unit of dynamic runtime functions that can be loaded, unloaded, started and stopped at runtime. They can also be configured to be automatically loaded and started at boot up.

---

## Tools

* `depmod`- Handle dependency descriptions for loadable kernel modules.
* `insmod` - Install loadable kernel module.
* `lsmod` - List loaded modules.
* `modinfo` - Display information about a kernel module.
* `modprobe` - High level handling of loadable modules.
* `rmmod` - Unload loadable modules.

---

## Configuration

* `modules.conf` - Configure the loading of modules before the rest of the services regardless of run-level.
* `rc.local` - Configures the loading of modules after all other services are started.

---

## References

* [How To](http://edoceo.com/howto/kernel-modules)