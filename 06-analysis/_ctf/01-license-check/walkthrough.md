## Simple License Check Walkthrough

1. Investigate the binary `main` function:

    1. `gdb $PROGRAM`

    2. `gdb> set disassembly-flavor intel` (change from AT&T format).

    3. `gdb> disassemble main`

        ```bash
        Dump of assembler code for function main:
        => 0x0000555555555189 <+0>:	endbr64 
        0x000055555555518d <+4>:	push   %rbp
        0x000055555555518e <+5>:	mov    %rsp,%rbp
        0x0000555555555191 <+8>:	sub    $0x10,%rsp
        0x0000555555555195 <+12>:	mov    %edi,-0x4(%rbp)
        0x0000555555555198 <+15>:	mov    %rsi,-0x10(%rbp)
        0x000055555555519c <+19>:	cmpl   $0x2,-0x4(%rbp)
        0x00005555555551a0 <+23>:	jne    0x5555555551fb <main+114>
        0x00005555555551a2 <+25>:	mov    -0x10(%rbp),%rax
        0x00005555555551a6 <+29>:	add    $0x8,%rax
        0x00005555555551aa <+33>:	mov    (%rax),%rax
        0x00005555555551ad <+36>:	mov    %rax,%rsi
        0x00005555555551b0 <+39>:	lea    0xe4d(%rip),%rdi        # 0x555555556004
        0x00005555555551b7 <+46>:	mov    $0x0,%eax
        0x00005555555551bc <+51>:	callq  0x555555555080 <printf@plt>
        0x00005555555551c1 <+56>:	mov    -0x10(%rbp),%rax
        0x00005555555551c5 <+60>:	add    $0x8,%rax
        0x00005555555551c9 <+64>:	mov    (%rax),%rax
        0x00005555555551cc <+67>:	lea    0xe47(%rip),%rsi        # 0x55555555601a
        0x00005555555551d3 <+74>:	mov    %rax,%rdi
        0x00005555555551d6 <+77>:	callq  0x555555555090 <strcmp@plt>
        0x00005555555551db <+82>:	test   %eax,%eax
        0x00005555555551dd <+84>:	jne    0x5555555551ed <main+100>
        0x00005555555551df <+86>:	lea    0xe44(%rip),%rdi        # 0x55555555602a
        0x00005555555551e6 <+93>:	callq  0x555555555070 <puts@plt>
        0x00005555555551eb <+98>:	jmp    0x555555555207 <main+126>
        0x00005555555551ed <+100>:	lea    0xe46(%rip),%rdi        # 0x55555555603a
        0x00005555555551f4 <+107>:	callq  0x555555555070 <puts@plt>
        0x00005555555551f9 <+112>:	jmp    0x555555555207 <main+126>
        0x00005555555551fb <+114>:	lea    0xe3f(%rip),%rdi        # 0x555555556041
        0x0000555555555202 <+121>:	callq  0x555555555070 <puts@plt>
        0x0000555555555207 <+126>:	mov    $0x0,%eax
        0x000055555555520c <+131>:	leaveq 
        0x000055555555520d <+132>:	retq 
        ```

3. Get an idea of the `program structure` and `logical flow`. Make a `flow diagram`. Look for:

    1. __Call operations__ - `call` - Use the `man` page to understand any standard c library call. _Record memory addresses_.

    2. __Comparison Operations__ - `cmp` - These are usually performed before jumps in control flow.

    3. __Jump operations__ - `jne` - These are jumps in control flow. _Record memory addresses_.

    4. __Return operations__ - `ret` - These return back to original control flow.  _Record memory addresses_.

4. When a graph of the logical flow of program is obtained, debug the execution and examine each branch:

    1. Set a breakpoint int he main function - `(gdb) break main`

    2. Run the program - `(gdb) run`

        1. View the registers - `(gdb) info registers`

        2. `step into` function - `(gdb) si`

        3. `next instruction` function - `(gdb) ni`

            * `enter` wil execute the last instruction.
        
        4. Follow the main instructions, eventually we hit `0x51a0` and jump to `0x51fb` then execute the `puts` operation.

            ```bash
            Breakpoint 1, 0x0000555555555189 in main ()
            (gdb) si
            0x000055555555518d in main ()
            (gdb) ni
            0x000055555555518e in main ()
            (gdb) ni
            0x0000555555555191 in main ()
            (gdb) ni
            0x0000555555555195 in main ()
            (gdb) ni
            0x0000555555555198 in main ()
            (gdb) ni
            0x000055555555519c in main ()
            (gdb) ni
            0x00005555555551a0 in main ()
            (gdb) ni
            0x00005555555551fb in main ()
            (gdb) 
            0x0000555555555202 in main ()
            (gdb) 
            Usage: <key>
            0x0000555555555207 in main ()
            ```
        * So the `puts` at `0x5202` is implementing the _usage_ information.

    3. Run the program with an argument to check the other branch.

        ```bash
        (gdb) 
        0x00005555555551bc in main ()
        (gdb) 
        Checking License: wibble
        0x00005555555551c1 in main ()
        ```

        * So the `printf` at `0x51bc` is implementing the _error_ information.
    
    4. Run the program with input `run XXX` and set a breakpoint at `0x00005555555551db`

        * `0x00005555555551db <+82>:	test   %eax,%eax` - This is the test for a correct password.

        ```bash
        (gdb) break *0x00005555555551db
        Breakpoint 2 at 0x5555555551db
        ```
    
    5. Set the value to `0` to pass the check:

        ```bash
        set $eax = 0
        ```

    6. Run til completion.

        ```bash
        (gdb) ni
        0x00005555555551dd in main ()
        (gdb) 
        0x00005555555551df in main ()
        (gdb) 
        0x00005555555551e6 in main ()
        (gdb) 
        Access Granted!
        ```
