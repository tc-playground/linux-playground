# Linux Namespaces

## Introduction

* `linux namespaces` are ` `linux kernel feature`.

* `linux namespaces` allow segregation and isolation of OS resources.

* `linux namespaces` are the enabling technology for `containers`.

> NB: `linux namespace resources` share the same `kernel`.

---

## 6 (7) Linux Namespaces

1. `PID` - Isolate the `PID` number space - Isolates processes in a tree hierarchy.

2. `User` - Isolate UID/GID number spaces - Isolates users and groups.

3. `Mount` - Isolate filesystem mount points - Isolates filesystems.

4. `UTS` - Isolate hostname and domainname - Isolates hosts and domains.

5. `Network` - Isolate network interfaces - Isolates networks.

6. `IPC` - Isolate interprocess communication (IPC) resources - Isolates IPC channels.

7. `Cgroup` - Isolate cgroup root directory - Puts resources restrictions on isolated resources.

    > NB: CGroups are not `namespaces` but often used in conjunction with them.

---

## Namespace Commands

* `unshare` - Run program with some namespaces unshared from parent. The namespaces to be unshared are indicated via options:

    * `mount namespace` - Mounting and unmounting filesystems will not affect the rest of the system.

    * `UTS namespace` - Setting  `hostname`  or `domainname` will not affect the rest of the system.

    * `IPC namespace` - The process will have an independent namespace for POSIX message queues as well as System V message queues, semaphore sets and shared memory segments.

    * `network namespace` - The process will have independent `IPv4` and `IPv6` stacks, IP routing tables, firewall rules, the /proc/net and /sys/class/net directory trees, sockets, etc.

    * `PID namespace` - Children will have a distinct set of `PID-to-process mappings` from their parent.

    * `cgroup namespace` - The process will have a `virtualized view of /proc/self/cgroup`, and new cgroup mounts will be rooted at the namespace cgroup root.

    * `user namespace` - The process will have a distinct set of `UID`s, `GID`s  and `capabilities`.

* `pivot_root` - Change the root filesystem. Used to switch an unshared child process to a new a new root file system.

* `ip` - Used to configure a new unshared child processes network stack.


---

## References

* [Man - namespaces/7 - Programmer Manual](http://man7.org/linux/man-pages/man7/namespaces.7.html)

* [Man - unshare/1 - User Command](http://man7.org/linux/man-pages/man1/unshare.1.html)

* [Man - unshare/2 - Programmer Manual](http://man7.org/linux/man-pages/man1/unshare.2.html)

* [Wikipedia](https://en.wikipedia.org/wiki/Linux_namespaces)

* [Golang Tutorial](https://medium.com/@teddyking/linux-namespaces-850489d3ccf)

* [C Language Tutorial](https://www.toptal.com/linux/separation-anxiety-isolating-your-system-with-linux-namespaces)
