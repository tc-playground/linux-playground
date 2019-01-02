# The Linux 'proc' Filesystem

## Introduction

The `proc` filesystem (`procfs`) is a special 'pseudo filesystem' in Unix-like operating systems that presents information about __processes__ and other system information in a hierarchical file-like structure using `virtual files`..

The `proc` filesystem provides a method of communication between __kernel space__ and __user space__. For example, `ps` uses the proc file system to obtain its data, without using any specialized system calls.


The `proc` filesystem is mapped to a mount point named `/proc` at boot time. The proc file system acts as an interface to internal data structures in the kernel. It can be used to obtain information about the system and to change certain kernel parameters at runtime via `sysctl`.

The `proc` filesystem  has siblings such as the `sys` file system for system devices. 

The Linux kernel extends it to non–process-related data.

---

## Linux `/proc` Overview

### Linux `/proc`

`/proc` also includes non-process-related system information.

* `/proc/acpi` A _directory_ containing various bits of information about the state of power management.
* `/proc/buddyinfo` - A _text file_ containing information about the `buddy algorithm` that handles memory fragmentation.
* `/proc/bus` - A _directory_ containing directories representing various `buses` on the computer, such as `input/PCI/USB`. See `/sys/bus` for more detailed information.
* `/proc/fb` - A _text file_ containing a list of the available `framebuffers`.
* `/proc/cmdline` - A _text file_ containing the `boot options` passed to the kernel.
* `/proc/cpuinfo` - A _text file_ containing information about the CPU.
* `/proc/crypto` - A _text file_ containing a list of available cryptographic modules.
* `/proc/devices` - A _text file_ containing a list of `character devices` and `block devices` sorted by `device ID` and giving the `major part` of the `/dev` name too. __NB__: The kernel will assign a major/minor number pair when it detects a hardware device while booting the system as defined by the _Linux Assigned Name and Number Authority_.
* `/proc/diskstats` - A _text file_ containing giving some information (including device numbers) for each of the `logical disk devices`.
* `/proc/filesystems` - A _text file_ containing a list of the `file systems` supported by the kernel at the time of listing.
* `/proc/interrupts` - A _text file_ containing details about the `interrupts` in-relation to `physical/logical devices` using the system resources. See also, `/proc/iomem`, `/proc/imports` and the _directory_ `/proc/irq`.
* `/proc/kmsg` - A _text file_ containing `messages` output by the kernel. __NB__: Use `dmesg` instead.
* `/proc/kallsyms` - A _text file_ containing the `kernel symbol table`.
* `/proc/meminfo` - A _text file_ containing a summary of how the kernel is managing its memory.
* `/proc/modules` - A _text file_ containing a list of the kernel modules currently loaded.
* `/proc/mounts` - A _symlink_ to `self/mounts` which contains _text file_ a list of the currently `mounted devices` and their `mount options`.
* `/proc/net/` - A _symlink_ to `self/net` which contains _directory_ containing useful information about the `network stack`. This contains LOTS of nw information, e.g. `arp table`, `route table`, `network stats1, etc, etc.
    * `stat` - Various network statistics.
* `/proc/partitions` - A _text file_ containing a list of the `device-numbers`, their size and `/dev names` which the kernel has identified as existing partitions.
* `/proc/scsi` - A _directory_ containing information about any devices connected via a `SCSI` or `RAID` controller.
* `/proc/self` - A symbolic link to the current (traversing) process at `/proc/self` (i.e. /proc/PID/ where PID is that of the current process).
* `/proc/slabinfo` - A _text file_ listing statistics on the caches for frequently-used objects in the Linux kernel.
* `/proc/swaps` - A _text file_ listing the `active swap` partitions, their various sizes and priorities.
* `/proc/sys` - A _directory_ containing `dynamically-configurable kernel options`. Under `/proc/sys` appear hierarchical directories representing the _areas of kernel_, and each contains readable and writable `virtual files`. For example, a commonly referenced virtual file is `/proc/sys/net/ipv4/ip_forward`, because it is necessary for `routing firewalls` or `tunnels` (ip forwarding). The file contains either a '1' or a '0': if it is 1, the IPv4 stack forwards packets not meant for the local host, if it is 0 then it does not.
* `/proc/sysvipc` - A _directory_ containing `memory-sharing` and `inter-process communication` (IPC) information.
* `/proc/tty` - A _directory_ containing information about the current `terminals`. `/proc/tty/driver` is a list of the different types of tty available.
* `/proc/uptime` - A _text file_ containing the length of time the kernel has been running since boot and spent in idle mode (both in seconds).
* `/proc/version` - A _text file_ containing the Linux kernel version, distribution number, gcc version number (used to build the kernel) and any other pertinent information relating to the version of the kernel currently running


#### Linux `/proc/<pid>`

Linux includes a directory for each running process, including kernel processes, in directories named `/proc/<pid>`, where __<pid>__ is the process number. For example:

* `/proc/PID/cgroup` - A _text file_ containing the `cgroup` configuration for the process.
* `/proc/PID/cmdline` - The _command_ that originally started the process.
* `/proc/PID/cwd` - A _symlink_ to the current working directory of the process.
* `/proc/PID/environ` - A _text file_ containing the names and values of the environment variables that affect the process.
* `/proc/PID/exe` - A _symlink_ to the original executable file, if it still exists.
* `/proc/PID/fd` - A _directory_ containing a symbolic link for each open file descriptor.
* `/proc/PID/fdinfo` - A _directory_ containing entries which describe the position and flags for each open file descriptor.
* `/proc/PID/maps` - A _text file_ containing information about mapped files and blocks (like heap and stack).
* `/proc/PID/mem` - A _binary image_ representing the process's virtual memory, can only be accessed by a `ptrace`-ing process.
* `/proc/PID/root` - A _symlink_ to the root path as seen by the process. For most processes this will be a link to `/` unless the process is running in a `chroot jail`.
* `/proc/PID/status` - A _text file_ containing basic information about a process including its run state and memory usage.
* `/proc/PID/task` - A _directory_ containing hard links to any tasks that have been started by this (i.e.: the parent) process.


## Linux `/sys`

`sys` is separate pseudo-file system, `sysfs`, mounted under `/sys`.

---

## References

* [Wikipedia](https://en.wikipedia.org/wiki/Procfs)
* [/proc/kmsg hanging](https://unix.stackexchange.com/questions/117985/does-syslogd-cause-cat-proc-kmsg-not-to-work-properly)
* []Man page](http://man.cat-v.org/unix_8th/4/proc)