# `/etc/fstab`

## Introduction

* `fstab` (Filesystem Table) provide static information about the filesystems.

* `fstab` contains descriptive information about the `filesystems` the system can `mount`.

* `fstab` record ordering is important because `fsck`,  `mount`, and  `umount` sequentially iterate through them.

---

## Use-cases

* `fstab` can be used to automatically mount a filesystem on system start-up.

* `fstab` can be used to automatically check, repair, and back backup mounted filesystems.

---

## File Format

* `fstab` is a text file.

* `fstab` describes each `filesystem` on a separate line.

    1. `Label` - This field describes the block special device or remote filesystem to be mounted.

    2. `Mount Point` - This  field describes the mount point (target) for the filesystem

    3. `Filesystem Type` - This field describes the type of the filesystem.

    4. `Mount Options` - The mount options associated with the filesystem.

    > e.g. ```LABEL=t-home2   /home      ext4    defaults,auto_da_alloc      0  2```

    5. `Dump` - This field is used by `dump` to determine which filesystems need to be dumped.

    6. `Passing` - This field is used by `fsck` to determine the order in which filesystem checks are done at boot time.

---

## Example

```bash
# device-spec   mount-point     fs-type      options                                          dump pass
LABEL=/         /               ext4         defaults                                            1 1
/dev/sda6       none            swap         defaults                                            0 0
none            /dev/pts        devpts       gid=5,mode=620                                      0 0
none            /proc           proc         defaults                                            0 0
none            /dev/shm        tmpfs        defaults                                            0 0

# Removable media
/dev/cdrom      /mnt/cdrom      udf,iso9660  noauto,owner,ro                                     0 0

# NTFS Windows 7 partition
/dev/sda1       /mnt/Windows    ntfs-3g      quiet,defaults,locale=en_US.utf8,umask=0,noexec     0 0

# Partition shared by Windows and Linux
/dev/sda7       /mnt/shared     vfat         umask=000                                           0 0

# mounting tmpfs
tmpfs           /mnt/tmpfschk   tmpfs        size=100m                                           0 0

# mounting cifs
//pingu/ashare  /store/pingu    cifs         credentials=/root/smbpass.txt                       0 0

# mounting NFS
pingu:/store    /store          nfs          rw                                                  0 0
```

---

## Usage

* `fstab` is read-only and intended to be managed by an administrator: `vim /etc/fstab`

---

## References

* `man fstab`

* [Wikipedia](https://en.wikipedia.org/wiki/Fstab)

