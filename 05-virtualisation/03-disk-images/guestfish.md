# guestfish

---

## Introduction

__guestfish__ is a shell and command-line tool for examining and modifying virtual machine filesystems. It uses `libguestfs` and exposes all of the functionality of the guestfs API, see `guestfs(3)`.

__guestfish__ should only be used when the target disk image is not running. It can then be used to update that image.

---

## References

* [Home](http://libguestfs.org/)
* [Manual](http://libguestfs.org/guestfs.3.html)
* [guestfish](http://libguestfs.org/guestfish.1.html)
* [guestfish recipes](http://libguestfs.org/guestfs-recipes.1.html)
* [Modify Images - Open Stack](https://docs.openstack.org/image-guide/modify-images.html)
* [HOW TO: Modify a gcow image](https://blog.scottlowe.org/2014/03/17/modifying-qcow-images-with-guestfish/)
* [HOW TO: Set a default password on an OS image](https://ask.openstack.org/en/question/5531/defining-default-user-password-for-ubuntu-cloud-image/)
