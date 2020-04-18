# Analysis Tools

## Simple Tools

1. `bc` - A simple calculator.

---

## Binary File Tools

1. `file` - Get the file information and metadata.

2. `hexdump -C` - View a binary file as hexadecimal.

3. `objdump -d` - Disassembled binary. This can be used to find the memory locations for ares of interest.

4. `strings $LEN` - Find all the strings in a binary file that are longer than the specified length.

---

## Execution Tracers

1. `strace` - Trace _system calls__.

2. `ltrace` - Trace _library calls_.

3. `bpftrace` - Trace using `BPF language` expressions on `probes`.

---

## Debugger and Disassembler

1. `gdb disassemble $FUNCTION` - Debugger and disassembler.

2. `r2` - `redare` reverse-engineering disassembler.
 

