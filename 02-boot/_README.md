# Linux Start-up Process

## Steps

0. `BIOS / UEFI Phase`

    1. Power on causes the `BIOS` / `UEFI` to load the selected `bootloader` (from disk, USB, etc.).

1. `Boot Loader Phase`

    1. The specified `boot loader` will load the defined `kernel`.

    2. The specified `boot loader` will create a temporary ram disk or filesystem - `initrd` or `initramfs`.

    > NB: The current most common bootloader for linux systems is `GRUB 2`.

2. `Kernel Phase`

    1. The `kernel` is loaded from a predefined location in memory and executed with `start_kernel()`.
    
    2. The `kernel` initializes the system `memory` and `virtual memory`.

    2. The `kernel`initializes the `hardware`:

        1. Processors.
        
        2. I/O subsystems,
        
        3. Storage devices.

    3. The `kernel` initialize a compressed `initrd image` or `initramfs filesystem` from a predetermined location in memory:
    
        1. Decompresses image/filesystem. 
        
        2. Mounts image/filesystem.
        
        2. Loads all necessary drivers. 
        
    4. The `kernel` initializes `virtual devices` related to the file system: 
    
        1. `LVM`.
        
        2. `Software RAID`. 
        
    5. The `kernel` unmounts the `initrd disk image`/`initramfs filesystem` and frees the memory.
        
    6. The `kernel` creates a `root device`.
    
    7. The `kernel` mounts the `root partition read-only`. 
        
    8. The `kernel` is now loaded into memory and operational. 
    
    9. The `kernel` now enables `interrupts` and the `scheduler` (for `pre-emptive multi-tasking`) can take control of the overall management of the system.
    
    10. The init process is left to continue booting the user environment in user space.


3. `Early User Space Phase`

    1. `initramfs`, also known as `early user space`. 
    
    2. Typical uses of `early user space` are to detect what device drivers are needed to load the main user space file system and load them from a temporary filesystem.

4. `User Space - Init Process Phase`

    1. Once the kernel has started, it starts the `init` process to create `userspace`. There are several common options for `service management`.

        1. `SysV init` - The parent of all processes on the system, it is executed by the kernel and is responsible for starting all other processes. It is the parent of all processes whose natural parents have died and it is responsible for reaping those when they die. Processes managed by `init` are known as `jobs` and are defined by files in the `/etc/init` directory. __This is the original UNIX manager__.

        2. `systemd` -  A `daemon` that manages other daemons. All daemons, including systemd, are background processes. Systemd is the first daemon to start (during booting) and the last daemon to terminate (during shutdown). __The most common service manager__.

        3. `Upstart` - An asynchronous init manager that handles starting of the tasks and services during boot and stopping them during shutdown, and also supervises the tasks and services while the system is running.

        4. `runit` - A reimplementation of `daemontools`.
    
---

## References

* [Wikipedia](https://en.wikipedia.org/wiki/Linux_startup_process)