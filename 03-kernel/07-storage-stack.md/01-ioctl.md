# `ioctl` system call

## Introduction

* `ioctl (Input/Output control` is a __system call__ for device-specific input/output operations and other operations which cannot be expressed by regular system calls.

* `ioctl` takes two parameters:

    1. An open `file descriptor` representing the target device.

    2. A `request code`; _the effect of a call depends completely on the request code_.

    3. An integer representing data; or, a pointer to a data area.

* `ioctl requests codes` are often device specific. e.g. a `device driver` to perform an operation on some hardware device.

* `ioctl` provides a generic system call for interacting with `hardware devices` without requiring a large number of specialised `system calls`.

* `ioctl` is a `vectored call interface`.

    * This can cause issues with `complexity` and `security` as effectively expose many `sub` system calls.

---

## Uses

1. __Hardware Device Configuration__ - `ioctl` is used to `control hardware devices`.

2. __Terminals__ - `ioctl` is exposed to end-user applications for `terminal I/O`.

3. __Kernel Extensions__ - `ioctl` calls provide a convenient way to bridge `userspace` code to `kernel extensions`.

---

## Alternatives

1. The `sysctl (System Control)` system call can sometimes be used for a similar purposes.

2. The `fcntl (File Control)` system call can sometimes be used for a similar purposes.

3. The `setsockopt (Set Socket Option)` system call can sometimes be used for a similar purposes.

4. `Memory Mapping` can be used to provide communication between `kernel space` and `user space`.

5. The `Netlink` interprocess communication (IPC)  can be used for a similar purposes.

---

## Resources

* [`ioctl - system call](https://en.wikipedia.org/wiki/Ioctl)

* [`sysctl - system call](https://en.wikipedia.org/wiki/Sysctl)

* [`Netlink - IPC](https://en.wikipedia.org/wiki/Netlink)
