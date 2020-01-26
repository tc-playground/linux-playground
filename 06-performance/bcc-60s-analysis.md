# BCC 60s Analysis

## Installation

* __Debian 10__

    ```
    sudo apt install bpfcc-tools
    sudo apt install bpftrace
    ```
* __Snapd__

    ```bash
    sudo apt install snapd
    sudo systemctl start snapd
    sudo snap install bcc
    ```

---

## Commands

1. `execsnoop` - Shows new process execution by printing one line of output for every `execve(2)`
syscall. Used to find short-lived processes.

2. `opensnoop` - shows new process execution by printing one line of output for every `open(2)`
syscall. Used to find files being accessed.

3. `ext4slower` - Traces common operations from the ext4 file system (reads, writes, opens, and
syncs) and prints those that exceed a time threshold 
    
    * Also: `btrfs*` , `xfs*` , `zfs*` ...

4.  `biolatency` - Traces disk I/O latency (that is, the time from device issue to completion) and
shows this as a histogram.

5. `biosnoop` - Prints a line of output for each disk I/O, with details including latency. This allows
you to examine disk I/O in more detail, and look for time-ordered pattern

6. `cachestat` - Prints a one-line summary every second (or every custom interval) showing statistics
from the file system cache. Use this to identify a low cache hit ratio and a high rate of misses.

7. `tcpconnect` - Prints one line of output for every active TCP connection (e.g., via connect()), with
details including source and destination addresses. Look for unexpected connections that may
point to inefficiencies in application configuration or an intruder.

8. `tcpaccept` - Prints one line of output for every passive
TCP connection (e.g., via accept()), with details including source and destination addresses.

9. `tcpretrans` - Prints one line of output for every TCP retransmit packet, with details including
source and destination addresses, and the kernel state of the TCP connection

10. `runqlat` - Times how long threads were waiting for their turn on CPU and prints this time as a
histogram

11. `profile` - A CPU profiler, a tool you can use to understand which code paths are consuming
CPU resources. It takes samples of stack traces at timed intervals and prints a summary of unique
stack traces and a count of their occurrence

