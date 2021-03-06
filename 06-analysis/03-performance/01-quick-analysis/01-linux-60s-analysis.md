# Linux 60s Analysis

## Installation

> `sudo apt install sysstat`

---

## Commands

1. `uptime` - View the `load averages`, which indicate the numbers od processes wanting to run.

2. `dmesg | tail` - View the `kernel error messages` to see if there is anything that might be causing performance issues.

3. `vmstat 1` - View the `virtual memory statistics` and process saturation.

4. `mpstat -P ALL 1` - View per `CPU time` broken down into `states`.

5. `pidstat 1` - View shows `CPU usage` per `process`.

6. `iostat -zv 1` - View `storage device I/O` metrics.

7. `free -m` - View `available memory in MB`.

8. `sar -n DEV 1` - View `network device` metrics.

9. `sar -n TCP,ETCP` - View `TCP` errors and metrics.

10. `top` - View an over all status of system performance.