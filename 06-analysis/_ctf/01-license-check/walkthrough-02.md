## Simple License Check Walkthrough 02

* Crack `licence-check` to get the password.

1. Use `file` to get a better understanding of the binary:

    ```bash
    $> file license-check
    license-check: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=6c865f06eefa8ae1838a1e7f56ecb6ab64e5d0aa, for GNU/Linux 3.2.0, not stripped
    ```

    1. `ELF 64-bit` is the binary file type

    2. `not stripped` mean the `gcc -g` debug information is preserved in the binary. 

        * The `strip` function can be used to remove this information.

2. Examine in `vim`:

    * Look for string, syscalls, library functions, and other readable text.

3. Examine using `hexdump -C` and `man ascii` to look up the the codes. 

    * Look for string, syscalls, library functions, and other readable text.

4. Examine using `objdump -s` to view the disassembly:

        ```bash
        $> objdump -x license-check | less

        license-check:     file format elf64-x86-64


        Disassembly of section .init:

        0000000000001000 <_init>:
            1000:       f3 0f 1e fa             endbr64 
            1004:       48 83 ec 08             sub    $0x8,%rsp
            1008:       48 8b 05 d9 2f 00 00    mov    0x2fd9(%rip),%rax        # 3fe8 <__gmon_start__>
            100f:       48 85 c0                test   %rax,%rax
            1012:       74 02                   je     1016 <_init+0x16>
            1014:       ff d0                   callq  *%rax
            1016:       48 83 c4 08             add    $0x8,%rsp
            101a:       c3  
            ...
            0000000000001189 <main>:
            1189:       f3 0f 1e fa             endbr64
            ...
            0000000000001288 <_fini>:
            1288:       f3 0f 1e fa             endbr64 
            128c:       48 83 ec 08             sub    $0x8,%rsp
            1290:       48 83 c4 08             add    $0x8,%rsp
            1294:       c3                      retq   
        ```

    * We can see this is the same as in the disassembler: `gdb> disassemble main`:
    
        ```bash
        Dump of assembler code for function main:
        0x0000000000001189 <+0>:     endbr64 
        0x000000000000118d <+4>:     push   %rbp
        ```

    * __NB__: There is more information than when just disassembling `main` as we have additional standard ELF file data.

5. Examine using `objdump -x` to see what modes are enabled and to view where code sections will land in memory:

    ```bash
    license-check:     file format elf64-x86-64
    license-check
    architecture: i386:x86-64, flags 0x00000150:
    HAS_SYMS, DYNAMIC, D_PAGED
    start address 0x00000000000010a0

    Program Header:
        PHDR off    0x0000000000000040 vaddr 0x0000000000000040 paddr 0x0000000000000040 align 2**3
            filesz 0x00000000000002d8 memsz 0x00000000000002d8 flags r--
    INTERP off    0x0000000000000318 vaddr 0x0000000000000318 paddr 0x0000000000000318 align 2**0
            filesz 0x000000000000001c memsz 0x000000000000001c flags r--
        LOAD off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**12
            filesz 0x0000000000000670 memsz 0x0000000000000670 flags r--
        LOAD off    0x0000000000001000 vaddr 0x0000000000001000 paddr 0x0000000000001000 align 2**12
            filesz 0x0000000000000295 memsz 0x0000000000000295 flags r-x
        LOAD off    0x0000000000002000 vaddr 0x0000000000002000 paddr 0x0000000000002000 align 2**12
            filesz 0x00000000000001a0 memsz 0x00000000000001a0 flags r--
        LOAD off    0x0000000000002da8 vaddr 0x0000000000003da8 paddr 0x0000000000003da8 align 2**12
            filesz 0x0000000000000268 memsz 0x0000000000000270 flags rw-
    DYNAMIC off    0x0000000000002db8 vaddr 0x0000000000003db8 paddr 0x0000000000003db8 align 2**3
            filesz 0x00000000000001f0 memsz 0x00000000000001f0 flags rw-
        NOTE off    0x0000000000000338 vaddr 0x0000000000000338 paddr 0x0000000000000338 align 2**3
            filesz 0x0000000000000020 memsz 0x0000000000000020 flags r--
        NOTE off    0x0000000000000358 vaddr 0x0000000000000358 paddr 0x0000000000000358 align 2**2
            filesz 0x0000000000000044 memsz 0x0000000000000044 flags r--
    0x6474e553 off    0x0000000000000338 vaddr 0x0000000000000338 paddr 0x0000000000000338 align 2**3
            filesz 0x0000000000000020 memsz 0x0000000000000020 flags r--
    EH_FRAME off    0x0000000000002050 vaddr 0x0000000000002050 paddr 0x0000000000002050 align 2**2
            filesz 0x0000000000000044 memsz 0x0000000000000044 flags r--
    STACK off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**4
            filesz 0x0000000000000000 memsz 0x0000000000000000 flags rw-
    RELRO off    0x0000000000002da8 vaddr 0x0000000000003da8 paddr 0x0000000000003da8 align 2**0
            filesz 0x0000000000000258 memsz 0x0000000000000258 flags r--

    Dynamic Section:
    NEEDED               libc.so.6
    INIT                 0x0000000000001000
    FINI                 0x0000000000001288
    INIT_ARRAY           0x0000000000003da8
    INIT_ARRAYSZ         0x0000000000000008
    FINI_ARRAY           0x0000000000003db0
    FINI_ARRAYSZ         0x0000000000000008
    GNU_HASH             0x00000000000003a0
    STRTAB               0x00000000000004a0
    SYMTAB               0x00000000000003c8
    STRSZ                0x0000000000000090
    SYMENT               0x0000000000000018
    DEBUG                0x0000000000000000
    PLTGOT               0x0000000000003fa8
    PLTRELSZ             0x0000000000000048
    PLTREL               0x0000000000000007
    JMPREL               0x0000000000000628
    RELA                 0x0000000000000568
    RELASZ               0x00000000000000c0
    RELAENT              0x0000000000000018
    FLAGS                0x0000000000000008
    FLAGS_1              0x0000000008000001
    VERNEED              0x0000000000000548
    VERNEEDNUM           0x0000000000000001
    VERSYM               0x0000000000000530
    RELACOUNT            0x0000000000000003

    Version References:
    required from libc.so.6:
        0x09691a75 0x00 02 GLIBC_2.2.5

    Sections:
    Idx Name          Size      VMA               LMA               File off  Algn
    0 .interp       0000001c  0000000000000318  0000000000000318  00000318  2**0
                    CONTENTS, ALLOC, LOAD, READONLY, DATA
    1 .note.gnu.property 00000020  0000000000000338  0000000000000338  00000338  2**3
                    CONTENTS, ALLOC, LOAD, READONLY, DATA
    2 .note.gnu.build-id 00000024  0000000000000358  0000000000000358  00000358  2**2
                    CONTENTS, ALLOC, LOAD, READONLY, DATA
    3 .note.ABI-tag 00000020  000000000000037c  000000000000037c  0000037c  2**2
                    CONTENTS, ALLOC, LOAD, READONLY, DATA
    4 .gnu.hash     00000024  00000000000003a0  00000000000003a0  000003a0  2**3
                    CONTENTS, ALLOC, LOAD, READONLY, DATA
    5 .dynsym       000000d8  00000000000003c8  00000000000003c8  000003c8  2**3
                    CONTENTS, ALLOC, LOAD, READONLY, DATA
    6 .dynstr       00000090  00000000000004a0  00000000000004a0  000004a0  2**0
                    CONTENTS, ALLOC, LOAD, READONLY, DATA
    7 .gnu.version  00000012  0000000000000530  0000000000000530  00000530  2**1
                    CONTENTS, ALLOC, LOAD, READONLY, DATA
    8 .gnu.version_r 00000020  0000000000000548  0000000000000548  00000548  2**3
                    CONTENTS, ALLOC, LOAD, READONLY, DATA
    9 .rela.dyn     000000c0  0000000000000568  0000000000000568  00000568  2**3
                    CONTENTS, ALLOC, LOAD, READONLY, DATA
    10 .rela.plt     00000048  0000000000000628  0000000000000628  00000628  2**3
                    CONTENTS, ALLOC, LOAD, READONLY, DATA
    11 .init         0000001b  0000000000001000  0000000000001000  00001000  2**2
                    CONTENTS, ALLOC, LOAD, READONLY, CODE
    12 .plt          00000040  0000000000001020  0000000000001020  00001020  2**4
                    CONTENTS, ALLOC, LOAD, READONLY, CODE
    13 .plt.got      00000010  0000000000001060  0000000000001060  00001060  2**4
                    CONTENTS, ALLOC, LOAD, READONLY, CODE
    14 .plt.sec      00000030  0000000000001070  0000000000001070  00001070  2**4
                    CONTENTS, ALLOC, LOAD, READONLY, CODE
    15 .text         000001e5  00000000000010a0  00000000000010a0  000010a0  2**4
                    CONTENTS, ALLOC, LOAD, READONLY, CODE
    16 .fini         0000000d  0000000000001288  0000000000001288  00001288  2**2
                    CONTENTS, ALLOC, LOAD, READONLY, CODE
    17 .rodata       0000004e  0000000000002000  0000000000002000  00002000  2**2
                    CONTENTS, ALLOC, LOAD, READONLY, DATA
    18 .eh_frame_hdr 00000044  0000000000002050  0000000000002050  00002050  2**2
                    CONTENTS, ALLOC, LOAD, READONLY, DATA
    19 .eh_frame     00000108  0000000000002098  0000000000002098  00002098  2**3
                    CONTENTS, ALLOC, LOAD, READONLY, DATA
    20 .init_array   00000008  0000000000003da8  0000000000003da8  00002da8  2**3
                    CONTENTS, ALLOC, LOAD, DATA
    21 .fini_array   00000008  0000000000003db0  0000000000003db0  00002db0  2**3
                    CONTENTS, ALLOC, LOAD, DATA
    22 .dynamic      000001f0  0000000000003db8  0000000000003db8  00002db8  2**3
                    CONTENTS, ALLOC, LOAD, DATA
    23 .got          00000058  0000000000003fa8  0000000000003fa8  00002fa8  2**3
                    CONTENTS, ALLOC, LOAD, DATA
    24 .data         00000010  0000000000004000  0000000000004000  00003000  2**3
                    CONTENTS, ALLOC, LOAD, DATA
    25 .bss          00000008  0000000000004010  0000000000004010  00003010  2**0
                    ALLOC
    26 .comment      0000002c  0000000000000000  0000000000000000  00003010  2**0
                    CONTENTS, READONLY
    SYMBOL TABLE:
    0000000000000318 l    d  .interp        0000000000000000              .interp
    0000000000000338 l    d  .note.gnu.property     0000000000000000              .note.gnu.property
    0000000000000358 l    d  .note.gnu.build-id     0000000000000000              .note.gnu.build-id
    000000000000037c l    d  .note.ABI-tag  0000000000000000              .note.ABI-tag
    00000000000003a0 l    d  .gnu.hash      0000000000000000              .gnu.hash
    00000000000003c8 l    d  .dynsym        0000000000000000              .dynsym
    00000000000004a0 l    d  .dynstr        0000000000000000              .dynstr
    0000000000000530 l    d  .gnu.version   0000000000000000              .gnu.version
    0000000000000548 l    d  .gnu.version_r 0000000000000000              .gnu.version_r
    0000000000000568 l    d  .rela.dyn      0000000000000000              .rela.dyn
    0000000000000628 l    d  .rela.plt      0000000000000000              .rela.plt
    0000000000001000 l    d  .init  0000000000000000              .init
    0000000000001020 l    d  .plt   0000000000000000              .plt
    0000000000001060 l    d  .plt.got       0000000000000000              .plt.got
    0000000000001070 l    d  .plt.sec       0000000000000000              .plt.sec
    00000000000010a0 l    d  .text  0000000000000000              .text
    0000000000001288 l    d  .fini  0000000000000000              .fini
    0000000000002000 l    d  .rodata        0000000000000000              .rodata
    0000000000002050 l    d  .eh_frame_hdr  0000000000000000              .eh_frame_hdr
    0000000000002098 l    d  .eh_frame      0000000000000000              .eh_frame
    0000000000003da8 l    d  .init_array    0000000000000000              .init_array
    0000000000003db0 l    d  .fini_array    0000000000000000              .fini_array
    0000000000003db8 l    d  .dynamic       0000000000000000              .dynamic
    0000000000003fa8 l    d  .got   0000000000000000              .got
    0000000000004000 l    d  .data  0000000000000000              .data
    0000000000004010 l    d  .bss   0000000000000000              .bss
    0000000000000000 l    d  .comment       0000000000000000              .comment
    0000000000000000 l    df *ABS*  0000000000000000              crtstuff.c
    00000000000010d0 l     F .text  0000000000000000              deregister_tm_clones
    0000000000001100 l     F .text  0000000000000000              register_tm_clones
    0000000000001140 l     F .text  0000000000000000              __do_global_dtors_aux
    0000000000004010 l     O .bss   0000000000000001              completed.8055
    0000000000003db0 l     O .fini_array    0000000000000000              __do_global_dtors_aux_fini_array_entry
    0000000000001180 l     F .text  0000000000000000              frame_dummy
    0000000000003da8 l     O .init_array    0000000000000000              __frame_dummy_init_array_entry
    0000000000000000 l    df *ABS*  0000000000000000              license-check.c
    0000000000000000 l    df *ABS*  0000000000000000              crtstuff.c
    000000000000219c l     O .eh_frame      0000000000000000              __FRAME_END__
    0000000000000000 l    df *ABS*  0000000000000000              
    0000000000003db0 l       .init_array    0000000000000000              __init_array_end
    0000000000003db8 l     O .dynamic       0000000000000000              _DYNAMIC
    0000000000003da8 l       .init_array    0000000000000000              __init_array_start
    0000000000002050 l       .eh_frame_hdr  0000000000000000              __GNU_EH_FRAME_HDR
    0000000000003fa8 l     O .got   0000000000000000              _GLOBAL_OFFSET_TABLE_
    0000000000001000 l     F .init  0000000000000000              _init
    0000000000001280 g     F .text  0000000000000005              __libc_csu_fini
    0000000000000000  w      *UND*  0000000000000000              _ITM_deregisterTMCloneTable
    0000000000004000  w      .data  0000000000000000              data_start
    0000000000000000       F *UND*  0000000000000000              puts@@GLIBC_2.2.5
    0000000000004010 g       .data  0000000000000000              _edata
    0000000000001288 g     F .fini  0000000000000000              .hidden _fini
    0000000000000000       F *UND*  0000000000000000              printf@@GLIBC_2.2.5
    0000000000000000       F *UND*  0000000000000000              __libc_start_main@@GLIBC_2.2.5
    0000000000004000 g       .data  0000000000000000              __data_start
    0000000000000000       F *UND*  0000000000000000              strcmp@@GLIBC_2.2.5
    0000000000000000  w      *UND*  0000000000000000              __gmon_start__
    0000000000004008 g     O .data  0000000000000000              .hidden __dso_handle
    0000000000002000 g     O .rodata        0000000000000004              _IO_stdin_used
    0000000000001210 g     F .text  0000000000000065              __libc_csu_init
    0000000000004018 g       .bss   0000000000000000              _end
    00000000000010a0 g     F .text  000000000000002f              _start
    0000000000004010 g       .bss   0000000000000000              __bss_start
    0000000000001189 g     F .text  0000000000000085              main
    0000000000004010 g     O .data  0000000000000000              .hidden __TMC_END__
    0000000000000000  w      *UND*  0000000000000000              _ITM_registerTMCloneTable
    0000000000000000  w    F *UND*  0000000000000000              __cxa_finalize@@GLIBC_2.2.5
    ```

    1. `STACK off` - Stack execution is not enabled.

    2. `Byte Size` `Start Address` : `000001e5 + 00000000000010a0 = 0x1285` should be where where `main` starts `0x1285`?

        ```bash
        15 .text         000001e5  00000000000010a0  00000000000010a0  000010a0  2**4
                        CONTENTS, ALLOC, LOAD, READONLY, CODE
        ```

        > NB: not sure where the extra 4 bytes is coming from!
    
    3. Find the `strcmp` call is `gdb` and break point its location. `x/s $RSI_ADDR` address should give the secret! `x/s $RAX_ADDR` gives the guess.

6. Run the program with `strace` to see the _system_ calls.

7. Run the program with `ltrace` to trace the `libc` and other _library_ calls.

8. Examine the binary using `strings 1`:

    ```bash
    $> strings license-check
    /lib64/ld-linux-x86-64.so.2
    libc.so.6
    puts
    printf
    __cxa_finalize
    strcmpx/s
    __libc_start_main
    GLIBC_2.2.5
    _ITM_deregisterTMCloneTable
    __gmon_start__
    _ITM_registerTMCloneTable
    u+UH
    []A\A]A^A_
    Checking License: %s
    AAAA-Z10N-42-OK
    Access Granted!
    WRONG!
    Usage: <key>
    :*3$"
    GCC: (Ubuntu 9.2.1-9ubuntu2) 9.2.1 20191008
    crtstuff.c
    deregister_tm_clones
    __do_global_dtors_aux
    completed.8055
    __do_global_dtors_aux_fini_array_entry
    frame_dummy
    __frame_dummy_init_array_entry
    license-check.c
    __FRAME_END__
    __init_array_end
    _DYNAMIC
    __init_array_start
    __GNU_EH_FRAME_HDR
    _GLOBAL_OFFSET_TABLE_
    __libc_csu_fini
    _ITM_deregisterTMCloneTable
    puts@@GLIBC_2.2.5
    _edata
    printf@@GLIBC_2.2.5
    __libc_start_main@@GLIBC_2.2.5
    __data_start
    strcmp@@GLIBC_2.2.5
    __gmon_start__
    __dso_handle
    _IO_stdin_used
    __libc_csu_init
    __bss_start
    main
    __TMC_END__
    _ITM_registerTMCloneTable
    __cxa_finalize@@GLIBC_2.2.5
    .symtab
    .strtab
    .shstrtab
    .interp
    .note.gnu.property
    .note.gnu.build-id
    .note.ABI-tag
    .gnu.hash
    .dynsym
    .dynstr
    .gnu.version
    .gnu.version_r
    .rela.dyn
    .rela.plt
    .init
    .plt.got
    .plt.sec
    .text
    .fini
    .rodata
    .eh_frame_hdr
    .eh_frame
    .init_array
    .fini_array
    .dynamic
    .data
    .bss
    .comment
    ```

9. Install [Hopper](https://www.hopperapp.com/) and disassemble the executable.

---

## References

