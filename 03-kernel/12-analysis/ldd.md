# `ldd`

## Introduction

* `ldd` prints the shared objects (shared libraries) required by each program or shared object specified on the command line.

    ```
    $> ldd $(which ls)
            linux-vdso.so.1 (0x00007ffdc5d29000)
            libselinux.so.1 => /lib/x86_64-linux-gnu/libselinux.so.1 (0x00007fab8c7d2000)
            libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fab8c5e8000)
            libpcre.so.3 => /lib/x86_64-linux-gnu/libpcre.so.3 (0x00007fab8c574000)
            libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007fab8c56e000)
            /lib64/ld-linux-x86-64.so.2 (0x00007fab8ca39000)
            libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007fab8c54d000)
    ```
