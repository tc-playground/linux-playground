# Definitive Guide to System Calls

## Introduction

* `System calls` are how `a program enters the kernel` to perform some task. 

* Programs use `system calls` to perform a variety of operations such as: `creating processes`, doing `network and file IO`, and much more.

* Running a program which calls `open`, `fork`, `read`, `write`, etc. will result in making a `system call`.

    
    > NB:  `man syscalls 2` will get a list of system calls.

* `glibc` (and variants) provide `wrapper` to perform `system calls` in the `C` language.

    * It arranges the `arguments` and `enters the kernel`.

---

## Privilege Levels (x86)

* `Privilege levels` are a means of `access control`. 

* The privilege level determines which `CPU instructions` and `IO` may be performed.

    * The `kernel` runs at the most privileged level, called `Ring 0`.
    
    * `User` programs run at a lesser level, typically `Ring 3`.

---

## Interrupts

* An `interrupt` as an `event` that is generated (or “raised”) by `hardware` or `software`.

    * A `hardware interrupt` is raised by a hardware device to notify the kernel that a particular event has occurred. 
    
        > A common example of this type of interrupt is an interrupt generated when a NIC receives a packet.

    * A `software interrupt` is raised by executing a piece of code. 
    
        > On x86-64 systems, a `software interrupt` can be raised by executing the `int` instruction.

* Processors contain an `interrupt table`. Each `interrupt` is:

    * Defined by a `number`.
    
    * Has associated `options`, e.g. `privilege level` required ot execute. 

    * A `pointer` to the `code to execute` when that interrupt is called.

---

## Model Specific Registers (MSRs)

* `Model Specific Registers` are `control registers` that have a specific purpose to `control certain features of the CPU`.

    * `rdmsr` - The CPU instruction to `write` an MSR. 
    
    * `wrmsr` - The CPU instruction to `read` an MSR.

    * `msr-tools` - Tools for manipulating MSRs.

        ```
        % sudo apt-get install msr-tools
        % sudo modprobe msr
        % sudo rdmsr
        ```

---

## References

* [Definitive Guide to System Calls](https://blog.packagecloud.io/eng/2016/04/05/the-definitive-guide-to-linux-system-calls/)


* __Programmable Interrupt Controllers__

    * [8259 PIC](https://wiki.osdev.org/8259_PIC)

    * [APIC](https://wiki.osdev.org/APIC)

    * [IOAPIC](https://wiki.osdev.org/IOAPIC)
