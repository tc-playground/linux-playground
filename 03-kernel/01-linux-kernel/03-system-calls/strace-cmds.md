# strace Commands

1. Trace the system calls of the specified executable.

    ```bash
    `sudo strace $EXECUTABLE`
    ```

2. Attach to and tace the running program/service and log output to a file.

    ```bash
    sudo strace -f -p `pidof $PROGRAM` -o strace_log
    ```
