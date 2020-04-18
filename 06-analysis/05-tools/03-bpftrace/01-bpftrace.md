# BPF Trace

## Introduction

* `bpftrace` is a high-level tracing language for Linux enhanced Berkeley Packet Filter (eBPF) available in recent Linux kernels.

* `bpftrace` uses `LLVM` as a backend to compile scripts to BPF-bytecode and makes use of `BCC` for interacting with the Linux BPF system.

* `bpftrace` integrates with as well as existing Linux tracing capabilities: 

    * `kernel dynamic tracing (kprobes)`
    
    * `user-level dynamic tracing (uprobes)`
    
    * `tracepoints`.
 
 * The `bpftrace` language is inspired by awk and C, and predecessor tracers such as `DTrace` and `SystemTap`.

---

## References

* [bpftrace - Github](https://github.com/iovisor/bpftrace)

* [bpftrace - One Liners](https://github.com/iovisor/bpftrace/blob/master/docs/tutorial_one_liners.md)

* [bpftrace - Reference Guide](https://github.com/iovisor/bpftrace/blob/master/docs/reference_guide.md)

