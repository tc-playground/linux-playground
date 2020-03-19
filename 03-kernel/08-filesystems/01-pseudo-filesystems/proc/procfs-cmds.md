# procfs Commands

## Handling null-terminated string data

* Some `/proc` files contain null terminated strings that make the contents hard to read without re-formating:

    ```bash
    sudo cat /proc/16277/cmdline | sed 's/\x00/\x20/g' # '\x0A' for a line feed.
    sudo cat /proc/16277/cmdline | tr "\0" " "
    sudo cat /proc/16273/cmdline | strings -s " "
    ```

