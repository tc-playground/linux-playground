# Zircon (Fuchsia)

## Introduction

* `zircon` - Is an operating system kernel.

* `zircon` - is a `microkernel` (as opposed to a `monolithic`).

* `zircon` provides __syscalls__ to manage __processes__, __threads__, __virtual memory__, __inter-process communication__, __waiting on object state changes__, and __locking_ (via futexes).

* `zircon` __syscalls__ are generally non-blocking.

    * NB: `wait_one`, `wait_many`, `port_wait` and `thread sleep` are notable exceptions.

* `zircon` is the kernel for `fuchsia` - an open source `capability-based` operating system.

---

## References

* [Zircon Docs](https://fuchsia.dev/fuchsia-src/zircon)

* [Fuchsia OS - Wikipedia](https://en.wikipedia.org/wiki/Google_Fuchsia)

* [Fuchsia Docs](https://fuchsia.dev/fuchsia-src)
