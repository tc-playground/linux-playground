# Rsync

## Introduction

* `Rsync` is a fast and extraordinarily versatile file copying tool.

* `Rsync` designed to speed up file transfer by copying the differences between two files rather than copying an entire file every time.

* `Rsync` can keep to `local` or `remote` filesystems consistent.

* `Rsync` can preserve permissions and ownership information, copy symbolic links, and generally is designed to intelligently handle your files.

* Usage: `rsync [OPTION...] SRC... [DEST]`

---

## Usage

1. __Update a USB Backup__

    ```bash
    rsync -avh /home/usr/dir/ /media/disk/backup/
    ```

    1. `-dry-run`- Check what will be synchronised.

    2. `-delete` - Make sure the  local files.

2. __Restore a USB Backup__

    ```bash
    rsync -avh /media/disk/backup/ /home/usr/dir/ 
    ```

---

## References

* [`rsync` Tutorial](https://www.linux.com/news/back-expert-rsync/)

