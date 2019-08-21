# ps

## Introduction

`ps` displays information about a selection of the active processes.  If you want a repetitive update of the selection and the displayed information, use top(1) instead.

---

## Overview

`ps` selects all processes with the same effective user ID (euid=EUID) as the current user and associated with the same terminal as the invoker. It displays the process ID (pid=PID), the terminal associated with the process (tname=TTY), the cumulated CPU time in [DD-]hh:mm:ss format (time=TIME), and the executable name (ucmd=CMD).  Output is unsorted by default.

`ps` has many options for customising the format of the output. The options may use either 'standard' or 'BSD' syntax. The options also fall into groups for 'selection' and 'formatting'.

---

## Useful Options

### Output Selection
* __ax__ - Select all processes. Composite.
* __u__ - Select user-oriented format.
* __-A__ - Select all processes.  Identical to -e.
* __-U userlist__ - Select by real user ID (RUID) or name.
* __-u userlist__ - Select by effective user ID (EUID) or name.
* __-G grplist__ - Select by real group ID (RGID) or name.
* __-g grplist__ - Select by session OR by effective group name.
* __T__  Select all processes associated with this terminal.

### Output Format and Modifiers
* __s__ - Display signal format.
* __u__ - Display user-oriented format.
* __v__ - Display virtual memory format.
* __X__ - Register format.
* __f__ - Forest (process tre hierarchy).

### Sorting
* __k spec__ - Specify key sorting order. Sorting syntax is [+|-]key[,[+|-]key[,..].

---

## Examples

* __All processes (standard syntax)__ : `ps -ef`
* __All processes (BSD syntax)__ : `ps aux`
* __Process tree__ : `ps faux`
* __Process threads__ : `ps xmas`
* __All 'root' processes__ : `ps -U root -u root u`

---

## References

*__Man page__ - `man ps` 

