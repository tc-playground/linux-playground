# /proc/kallsyms - Kernel Symbol Tables

## Introduction

In programming language, a __symbol__ is either a __variable__ or a __function__. 

It is a name representing an space in the memory, which stores data (variables, or instructions (function, for executing).

A __global variable__ is defined outside of any function body. A __global function__ is declared without `inline` and `static`.

The are thousands f global symbols in the Linux kernel and these are listed listed in `/proc/kallsyms`.

## Example

```
$> cat /proc/kallsyms | head -n10
```
```
0000000000000000 A irq_stack_union
0000000000000000 A __per_cpu_start
0000000000000000 A cpu_debug_store
0000000000000000 A cpu_tss_rw
0000000000000000 A gdt_page
0000000000000000 A exception_stacks
0000000000000000 A entry_stack_storage
0000000000000000 A espfix_waddr
0000000000000000 A espfix_stack
0000000000000000 A cpu_llc_id
525 temple@occam:~/Work/dev/tc-play
```

## References
* [Introducing Kernel Symbol Tables](https://onebitbug.me/2011/03/04/introducing-linux-kernel-symbols/)