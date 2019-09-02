# Operating Systems

## Introduction

- A major function of the operating system is to hide all this complexity and give the programmer a more convenient set of instructions to work with.

- `I/O devices` are controlled by loading values into special `device registers`. 

    - A disk can be commanded to read by loading the values of the disk address, main memory address, byte count,and direction (read or write) into its registers.

    - Operating systems can hide such detail by providing a higher level `read`/`write` abstractions.

- The operating system is (usually) that portion of the software that runs in `kernel mode` or `supervisor mode`.

    - `kernel mode` is protected from user tampering by the hardware processor itself.

- Operating systems have historically been closely tied to thearchitecture of the computers on which they run.


---

## Architectural Abstraction Levels

1. Physical Devices

2. Micro Architecture

3. Machine Language / Assembler

4. Operating System

5. Applications

---

## What is an Operating System?

## The Operating System as an `Extended Machine`

- The function of the operating system is to present the user with the equivalent of an extended / virtual machine that is easier to program than the underlying hardware.

- Top-down view.

## The Operating System as a `Resource Manager`

- The function of the operating system is to provide for an orderly and controlled allocation of the processors, memories, and I/O devices among the various programs competing for them.

- Resource management includes `multiplexing (sharing) resources`  in two ways: 

    - `in time` - Multiple user programs share gets a `time-slice` of the processor, `IO`, etc.
    
    - `in space`- Multiple user programs share `memory`. `storage`, etc.



- Bottom-up view

---

## Evolution

- `vacuum tubes`

- `transistor main frames` 

- `batch systems`

- `IBM 360`

- `multiprogramming` - Prevent idleness of jobs by having multiple jobs in memory. When one needs `CPU` another can do `IO`.

    > `special hardware` is required to prevent multiple jobs interfering with one another.

- `spooling`

- `timesharing`

- `MULTICS`

- `distributed systems`









