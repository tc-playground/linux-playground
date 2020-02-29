# Virtual Machine Managers

## Introductions

* `Virtual machines` work on the principle that there are a certain amount of `resources` that they are entitled to (`disk`, `memory`, `processor cored` etc.). 

* When any `user program` (any program other than the OS) needs access to these resources, it does so by initiating `system calls` to the OS. 

* On a _physical machine_, the resident OS handles these syscalls by directly accessing the hardware. 

* On a _virtual machine_, the virtual machine does not have the privileges to access the hardware directly as it is a `userspace` program. 

     * This issues is handled by a process known as `trap-and-execute`.

---

## System Calls - Trap and Execute

1. `syscalls` to the guest OS are `trapped` and passed off to an appropriate `handler`.

2. The result of the syscall are then `simulated`: 

    * e.g. a syscall to write to the disk of the guest OS, would be simulated by a write in the file of the virtual machine disk in the host OS, and the result sent back to the program in the guest OS). 

> This process allows the guest OS to be fooled into thinking that it is running on a physical machine.
