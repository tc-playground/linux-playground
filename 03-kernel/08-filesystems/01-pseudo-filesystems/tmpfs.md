# tmpfs

## Introduction

`tmpfs` is a common name for a temporary file storage facility on many Unix-like operating systems. It is intended to appear as a mounted file system, but stored in volatile memory instead of a persistent storage device. A similar construction is a RAM disk, which appears as a virtual disk drive and hosts a disk file system.

On Linux `tmpfs` is based on the `ramfs` code used during `boot` and also uses the `page cache`, but unlike `ramfs` it supports swapping out less-used pages to swap space as well as filesystem size and inode limits to prevent out of memory situations.