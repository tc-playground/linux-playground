# How not to Boot a Kernel

---

## Introduction

* An overview on how to `create an image` and configure the `boot loader` that does not load the `linux kernel`.

---

## Steps

1. Install the required libraries.

2. Check `NASM` and `GCC` are working.

3. Create **`boot.asm`**

    * **sections**

        1. `.mulitboot` - Define memory location of (grub2) bootloader.

        2. `.text` - Define in scope functions. The internal `start` the bootloader should run, and, the `external C function`.

        3. `.start` - Define the `start` function to initialise the `stack space`, the `stack pointer` to point to the `stack space`, `call` the external C function, and then `halt` the processor. Also, we could enter an infinite loop (the `idle process`).

        4. `.bss` - Define the `stack space`.

    > **instructions** - `dd` (define double word), `dw` (define word), `db` (define bytes), `call` (call function), `cli` (disable interrupts by clearing the `IF` flag  in `EFLAGS` register), `mov` (move data), `hlt` (halt processor), `resb` (reserve stack space).

    > NB1: The `Stack` is a Last-In-First-Out (LIFO) data buffer.

    > NB2: The `Stack Pointer` is small register on the microprocessor that contains the `address of your program's last instruction` on the `Stack`. 

4. Create **`kernel.c`** to define the external function defined in `boot.asm`.

    1. Assigns the start address of your video memory to the string buffer.

    2. Does some stuff on the screen.

    3. Returns back to the boot code (where, if you recall, it halts the CPU).

    > NB : Video memory is running in `protected mode` and starts at memory address 0xB8000.

    > NB2: `protected mode` support 25 lines with 80 ASCII characters, and, 16 colours.

5. Create **`linker.ld`** to link the object files together.

    1. Define the `object file format` to be produced.

    2. Define the `ENTRY` to be the `start` function from `boot.asm`. This will run `main` from `kernel.c`.

    3. Specify the `offset address` where the linker should load the `kernel.c` binary. `1 MB` is where the bootloader will expect to find it.

6. Create the **`grub.cfg`** to configure the (Grub2) bootloader.

    1. Set a `time out` and define a `menu entry`.

7. Create a **`Makefile`** to build and link the `kernel` binary.

    ```bash
	nasm -f elf32 boot.asm -o boot.o
	gcc -m32 -c kernel.c -o kernel.o
	ld -m elf_i386 -T linker.ld -o kernel boot.o kernel.o
    ```

8. Make a bootable ISO image

    ```bash
    grub-mkrescue -o kustom-kernel.iso iso/
    ```

9. Run in QEMU/KVM

    1. Copy the kernel into your `iso pool`, eg:

        * `cp kustom-kernel.iso $HOME/temos/environments/kvm-local/kvm-iso`

    2. Open `Virtual Machine Manager` and `Create a new Virtual Machine`.

    3. Choose boot from ISO and select the `kustom-kernel.iso` image. Also, select the `Alt regular *alt.sisyphus` kernel type.

    4. Finish configuring the machine - give a small bit of memory, no disks, or networks, etc.

    5. Go!

---

## Notes

### Microcode

* `Microcode` is the underlying set of processor primitives that are used build hardware `machine code` and `instruction set operations`.

* `Machine code` is the raw bytes representing a sequence of microcode operations to implement an `instruction`.

* An 8-bit example:

    * 0, 1 — `opcode`
    * 2, 3 — `source register 1`
    * 4, 5 — `source register 2`
    * 6, 7 — `destination register`

    * `ADD A, B, C` => `00000110`
    
    * `SUB C, A, D` => `01100011`

---

### Object Code

* The `NASM assembler`, takes the assembly code and converts it into `object code` file.

* The `object file` is an intermediate step to produce the executable `binary`.

    * NB:  `object files` are a way of sharing and combining binaries.

* The ` gcc linker` takes all necessary `object files`, and combine them, and then produce a `binary program`.


---

## References

* [Make a Kernel](https://www.linuxjournal.com/content/what-does-it-take-make-kernel-0)

* [NASM Assembler](https://www.nasm.us/)

* [Grub - Mulitboot Header Fields](https://www.gnu.org/software/grub/manual/multiboot/html_node/Header-magic-fields.html)

* [Common Text Modes](https://en.wikipedia.org/wiki/Text_mode#PC_common_text_modes)

* [Linux Kernel Coding Style](https://www.kernel.org/doc/html/v4.10/process/coding-style.html)

* [Booting a Custom Linux Kernel](http://nickdesaulniers.github.io/blog/2018/10/24/booting-a-custom-linux-kernel-in-qemu-and-debugging-it-with-gdb/)



