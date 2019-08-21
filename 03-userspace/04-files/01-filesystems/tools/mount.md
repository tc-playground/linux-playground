# `mount`

## Introduction

* `mount` - Mounts a filesystem.

* `mount` can be used to list the currently mounted `fileystems`.

* `mount` can be used to mount a new `filesystem`.

> MB: `mount` is a complex command.

---

## Overview

* A `filesystem `is used to control how data is stored on the device or provided in a virtual way by network or another services.

* All `files` accessible in a Unix system are arranged in one big tree, the file hierarchy, rooted at `/`.

* These files can be spread out over several devices.  

* The `mount` command serves to attach the filesystem found on some device to the big file tree.  

> NB: The `umount`  command  will detach it again.

> NB2: Mounts can be persisted in `/etc/fstab` file.

---

## Use cases

* Listing mounts.

* Mount the items in '/etc/fstab'.

* Mount a device.

---

## Commands

* List mounts of the specified type - `mount [-l] [-t type]`

* Mount all filesystems mentioned in '/etc/fstab' - `mount -a [-t type] [-O optlist]`

* Create a new mount - `mount -t type device dir`

* Mount a device - `mount device dir`

---

## Reference

* `man mount`