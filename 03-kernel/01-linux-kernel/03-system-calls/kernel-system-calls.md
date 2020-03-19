# Linux Kernel System Calls


## Processes

`fork` - Create a child process,

`clone` - clone, __clone2 - Create a child process.

`execve` - Execute program.

`prctl` - operations on a process

`arch_prctl` - set architecture-specific thread state.

---

## Memory

`mmap` - mmap, munmap - map or un-map files or devices into memory.

`munmap` - mmap, munmap - map or un-map files or devices into memory.

`mprotect` - mprotect, pkey_mprotect - set protection on a region of memory.

`brk` - brk, sbrk - change data segment size (heap).

---

## Filesystem

`open`

`openat`

`close`

`read`

`write`

`fstat`- stat, fstat, lstat, fstatat - Get file status.

`fcntl` - manipulate file descriptor.

`pselect` - select, pselect, FD_CLR, FD_ISSET, FD_SET, FD_ZERO - synchronous I/O multiplexing

---

## Synchronisation

`futex` - Fast user-space locking

---

## General

* `unshare` - Unshare the specified namespaces of the target process.

* `setns` - Re-associate thread with a namespace.

* `nsenter` - Run program with namespaces of other processes

    * Enters the namespaces of one or more other processes and then executes the specified program. If program is not given, then ``${SHELL}'' is run (default: /bin/sh).

* `bpf` - Perform a command on an extended BPF map or program.

---

## Polling

`epoll-ctl` - Control interface for an epoll file descriptor.

`epoll_pwait` - epoll_wait, epoll_pwait - wait for an I/O event on an epoll file descriptor.

