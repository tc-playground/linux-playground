# Systemd

STUB

## Introduction

* `systemd` is a software suite that provides fundamental building blocks for a Linux operating system:

    * `init system` - Bootstrap the _user space_ and to manage system processes after booting.

    * `service manager` - Manage the configuration and life-cycle of daemons and services.

* `systemd` unifies basic configuration and service behaviors across Linux distributions.

* `systemd` is a replacement for the _UNIX System V_ and _Berkeley Software Distribution (BSD) init_ systems.

* `systemd` configuration files are located at: `/usr/lib/systemd`.

* `systemd unit/service files` are located at: `/usr/lib/systemd/system/`. 

    > __NB__: Also under: `/var/lib/systemd/` and `/etc/systemd/system`.

---

## References

* [Wikipedia](https://en.wikipedia.org/wiki/Systemd)
* [Home](https://www.freedesktop.org/wiki/Software/systemd/)
* [Repo](https://github.com/systemd/systemd)
* [Ubuntu Systemd Files](https://askubuntu.com/questions/876733/where-are-the-systemd-units-services-located-in-ubuntu)