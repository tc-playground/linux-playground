# Process Commands

## ps command

1. `ps aux` - Get all process information.

---

## pstree

1. `pstree $PID` - Display a tree of processes. PID default to 1.

2. `pstree -captl` - Display process tree with `arguments`, `process ids`, and, `no truncation`.

---

## pidof

1. `pidof $PROGRAM ` - Find the process ID of a running program.

---

## /proc

1. `sudo cat /proc/$PID/status` - Get process status from the proc filesystem.