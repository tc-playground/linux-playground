# `pivot_root` - Change the root filesystem

## Overview

* `pivot_root()` is `linux kernel` `system call` and a `linux command`.

    > NB: It has no `glibc` wrapper.

* `pivot_root` moves the `root filesystem` of the `calling process` to the directory `put_old` and makes `new_root` the `new root filesystem` of the `calling process`.

* `pivot_root` is called by the `kernel` during the `linux start-up process` to replace the `initramfs` with the `actual root filesystem`.

* `pivot_root` is called by `containerisation systems` when initializing a new `namespaced processes` with `mount namespace` filesystem.

* The caller of `pivot_root` must ensure that `processes` associated with the `old root` operate correctly afterwards. 

    > NB: For example, change their `root` and `current working directory` to `new_root` before invoking `pivot_root`.

---

## References

* [Man Page](http://man7.org/linux/man-pages/man2/pivot_root.2.html)