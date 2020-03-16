# Secure Boot and Kernel Lockdown Mode


* The so-called Kernel lockdown might cause issues with `kernel modules` and `bpf` and need to be disabled:

    1. Enable the `sysrq` mechanism (you may need to switch to root first):

       ```bash
       echo 1 > /proc/sys/kernel/sysrq
       echo x > /proc/sysrq-trigger
       ```

       or

       ```bash
       sysctl -w kernel.sysrq=1
       ```

    2. Disable kernel lockdown for the session:

        1. Press `Alt-PrintScr-x` on the keyboard.

        2. Check `dmesg`

            ```
            This sysrq operation is disabled from userspace.
            sysrq: Disabling Secure Boot restrictions
            Lifting lockdown
            ```

        NB: If the following is displayed ensure step 1. is executed.           
            
            ```
            [12697.055446] sysrq: This sysrq operation is disabled.
            ```

---

## References

* [Enable SYSRQ](https://askubuntu.com/questions/911522/how-can-i-enable-the-magic-sysrq-key-on-ubuntu-desktop)