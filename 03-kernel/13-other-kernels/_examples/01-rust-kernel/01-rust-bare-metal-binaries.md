# [Making a Bare Metal Rust Binary](https://os.phil-opp.com/freestanding-rust-binary/)

## Introduction

1. An `operating system kernel` must be `freestanding`/`bare metal` and not use dependencies on **existing operating system features**.

   - Use `threads`, `files`, `heap memory`, the `network`, `random numbers`, `standard output`, etc.

   - Link to existing library `binaries`.

   - Use any language features that make use of these.

2. Most of the `Rust standard library` CANNOT be used.

3. `Rust` iterators, closures, pattern matching, option and result, string formatting, and the ownership system CAN be used.

4. To achieve this with `Rust` you must create a `bare metal binary`.

---

## 1. **Set the `no_std` attribute**

- This prevents `rustc` from using an OS specific Rust `std` standard library. 

- It can be added as a global attribute to `src/main.rs`

    ```rust
    #![no_std]
    ```

---

## 2. **Fix `panic_impl` required language item**

- The `panic_impl` language item marks a function that is used for implementing __panic handling__.

    ```rust
    #[panic_handler]
    fn panic(_info: &PanicInfo) -> ! {
        loop {}
    }
    ```

> NB: This is a [`diverging function`](https://doc.rust-lang.org/1.30.0/book/first-edition/functions.html#diverging-functions).

---

## 3. **Fix `eh_personality` required language item**

- The `eh_personality` language item marks a function that is used for implementing __stack unwinding__.

- Rust can be configured to **abort on panic** instead via the `cargo.toml` configuration:

    ```
    [profile.dev]
    panic = "abort"

    [profile.release]
    panic = "abort"
    ```

---

## 4. **Fix `start` lang_item required language item**

- The `start` language item marks a function that is used for initialising a binaries __entry point__.

- As Rust main entry point is not available in the bare metal binary so one needs to be defined and the original overwritten:

    ```rust
    #![no_main]

    #[no_mangle]
    pub extern "C" fn _start() -> ! {
        loop {}
    }
    ```
- The original `main` function is no longer needed.

---

## 5. Fix Linker errors

- The `linker` assumes a `C program` is being linked.

- Either:

    1. Use `cargo` to `cross-compile` the binary for our target architecture: e.g.

        ```
        rustup target add thumbv7em-none-eabihf
        cargo build --target thumbv7em-none-eabihf
        ```

    2. The linker needs to configured not to include the `C runtime` via `linker arguments`. e.g.

        ```
        cargo rustc -- -C link-arg=-nostartfiles
        ```

---

## Notes

- Rust `Language items` are special **functions** and **types** that are required internally by the compiler.

    - e.g The `Copy` trait is a language item that tells the compiler which types have `copy semantics`.

- A language [`runtime`](https://en.wikipedia.org/wiki/Runtime_system) implements portions of an execution model required by the language.

    - e.g. `program initialisation`, `garbage collections`, etc.

- `crt0` - In a typical Rust binary that links the standard library, execution starts in a C runtime library called `crt0` (“C runtime zero”), which sets up the environment for a C application.

    - The `C runtime` invokes the entry point of the `Rust runtime`, which is marked by the `start` language item.

- Compiler/Linker `Triple Targets` are strings encoding the three values required by `rust` in order to cross compile.

    - `rustc --version --verbose` - The **host** value denotes the configured triple target:

        - e.g. `x86_64-unknown-linux-gnu`

            - `CPU` : x86_64
            - `vendor` : unknown
            - `OS` :linux
            - `ABI` : gnu.



---

## References

- [Rust `std` Standard Library](https://doc.rust-lang.org/std/)

- [Using Rust without the `std` Standard Library](https://doc.rust-lang.org/1.30.0/book/first-edition/using-rust-without-the-standard-library.html)

  - [Rust minimal `bare metal binary`](https://docs.rust-embedded.org/embedonomicon/smallest-no-std.html)

- [Rust runtime entrypoint](https://github.com/rust-lang/rust/blob/bb4d1491466d8239a7a5fd68bd605e3276e97afb/src/libstd/rt.rs#L32-L73)

- [LLVM Triple Targets](https://clang.llvm.org/docs/CrossCompilation.html#target-triple)

