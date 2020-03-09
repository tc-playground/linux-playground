# Assembly 101

## Basic CPU Instructions, Registers, and, Flags - 101

1. `Memory` - Contiguous set of addresses that the program is loaded into.

2. `Instruction Set` - A set of instruction to perform operations on values in the `registers`.

    1. __Arithmetic Ops__ - Instructions for performing arithmetic on data.

        * `add`, `sub` - Arithmetic operations on registers.

    2. __Conditional Ops__ - Instructions for performing conditional operation based on input data.

        * `cmp`, `jne`, `test` - Comparison operations that set `flags` based on the result of the comparison.

    3. __Control Flow Ops__ - Instructions for branching, jumping, and, returning by manipulating the address in the program counter.

        * `jmp`, `beq`, `neq`, `call` - Instructions for manipulating the program counter.

        > Control flow operation change the `program counter` register directly.

    4. __Data Ops__ - Instructions for loading, storing, and moving data.

        * `mov` - Move data between registers.

        * `push`, `pop` - Push and pop data from the `hanging stack` region of memory.

3. `Registers` - Locations to store `fixed size variables` that CPU instructions can operate upon.

    1. `Program Counter` - The `pc` register controls which _instruction to execute next_.

        * On x86 systems this register is called: `ip (instruction pointer)`, `eip` (32bit mode), `rip` (64-bit mode).

    > We can look at the value of the program counter to see what instruction will be executed next.

    2. `General Purpose Registers`

        * `RAX` is a 64bit general purpose register.

            * `EAX` is the first 32 bits of the `RAX` register.

    3. `Status Flags` - One or special registers whose bits record information about an operation, for example, if a comparison was equal.

        * Status flags are stored in `special register`.

4. __Memory__ - What does not fit currently in the `registers` is stored in `memory`:

    * __Heap__ - The memory that is not being used for the stack.

        * __Operations__ : `mov` is used to _store_ and _load_ values to and from `registers` and specified `memory addresses`.

    * __Stack__ - A special upper part of the memory is used to store the stack. The stack grows downwards. It tracks variables used in the execution of a program.

        * __Operations__ :  `push`, `pop`.

        * __Special Registers__ : `sp (stack pointer`, `bp (base pointer)`.

5. __Caches__ : Heap memory values are cached in the `L2` and `L3` hardware caches to improve performance.

---

## References

* [Binary Exploitation - LiveOverflow](https://www.youtube.com/playlist?list=PLhixgUqwRTjxglIswKp9mpkfPNfHkzyeN)

* [Reverser Engineering an Imaginary Trading Device](https://sockpuppet.org/issue-79-file-0xb-foxport-hht-hacking.txt.html)