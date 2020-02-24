# seccomp and seccomp-bpf

## Introduction

* `seccomp` - `secure computing mode` 

* `seccomp` is a computer security facility in the Linux kernel.

* `seccomp` was originally intended as a means of safely running untrusted compute-bound programs

* `seccomp` is often used to implement `sandboxes`.

* `seccomp` allows a process to make a one-way transition into a "secure" state where it cannot make any system calls except `exit()`, `sigreturn()`, `read()` and `write()` to already-open file descriptors. 

* `seccomp` ensure that if a restricted system call is attempted, the kernel will terminate the process with `SIGKIL`L or `SIGSYS`. 
    
* `seccomp` does not virtualize the system's resources - it isolates the process from them entirely.

* `seccomp-bpf` is an extension to `seccomp` that allows filtering of system calls using a configurable policy implemented using `Berkeley Packet Filter` rules.


---

## References

* [Seccomp - Wikipedia](https://en.wikipedia.org/wiki/Seccomp)

* [Seccomp Overview - LWN](https://lwn.net/Articles/656307/)

* [Seccomp Wiki](https://code.google.com/archive/p/seccompsandbox/wikis/overview.wiki)