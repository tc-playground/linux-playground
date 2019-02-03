# The Linux '/dev' Filesystem

## Introduction

* The `/dev` filesystem  is a special 'pseudo filesystem' in Unix-like operating systems that presents information about __device nodes__.

* The `/dev` filesystem provides a simple interface for applications to the devices.

* Hardware/Virtual devices are mounted under `/dev`:

    * __storage__ -> __scsi__ -> `/dev/sda`

    * __sound__ -> __snd__ -> `/dev/snd`
    
    * __tty__ -> __tty__ -> `/dev/tty`

    * etc...

* The `/dev` filesystem contains information on `block` (e.g. hard-disks) and `character` (e.g. serial) devices.

* The `/dev` filesystem contains information on the `major`/`minor` versions.

* The `/dev` filesystem is dynamically updated.

* On linux devices are managed by `udev`.

> NB: On MacOSX devices are managed by `devfs`.

---

## `/dev` Overview

* `lsmod` and `modinfo` - Can be used get information about modules loaded in the kernel.

* View `stdin`, `stdout`, and, `stderr`.

    ```
    $> ls -l std*
    lrwxrwxrwx 1 root root 15 Feb  3 07:08 stderr -> /proc/self/fd/2
    lrwxrwxrwx 1 root root 15 Feb  3 07:08 stdin -> /proc/self/fd/0
    lrwxrwxrwx 1 root root 15 Feb  3 07:08 stdout -> /proc/self/fd/1
    ```

* View `nvme` __block devices__.

    ```
    $> ls -l nvme0n*
    brw-rw---- 1 root disk 259, 0 Feb  3 07:08 nvme0n1
    brw-rw---- 1 root disk 259, 1 Feb  3 07:08 nvme0n1p1
    brw-rw---- 1 root disk 259, 2 Feb  3 07:08 nvme0n1p2
    brw-rw---- 1 root disk 259, 3 Feb  3 07:08 nvme0n1p3
    brw-rw---- 1 root disk 259, 4 Feb  3 07:08 nvme0n1p4
    brw-rw---- 1 root disk 259, 5 Feb  3 07:08 nvme0n1p5
    ```

* View `tty` ` __character device__.

    ```
$> ls -l tty
crw-rw-rw- 1 root tty 5, 0 Feb  3 07:08 tty
    ```





