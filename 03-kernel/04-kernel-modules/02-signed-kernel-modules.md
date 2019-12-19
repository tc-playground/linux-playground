# Signed Kernel Modules

## Introduction

* Kernel version `4.4.0-20` and greater enforce that `kernel modules` need be __signed__ when `UEFI firmware` has `Secure Boot` enabled.

* A public certificate needs to be added to the `MOK (Machine Owner Keys)` database that and used to check the authentcity of kernel modules.

* Examples modules that may required signing include `systemtap`, `vboxdrv`, etc.

---

## Signing and Registering a Kernel Module

1. __Create__ a new `key pair`:

    ```bash
    openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out MOK.der -nodes -days 36500 -subj "/CN=Descriptive common name/"
    ```

    * __Optional__ : For additional security, skip the `-nodes` switch, which will then ask for a password. Then before moving on to the next step, make sure to export `KBUILD_SIGN_PIN='yourpassword'`.

2. __Sign__ the reuired `$kernel_module` with the key and enter a `password` which on reboot willbe used to `register` the module:

    ```bash
    sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./MOK.priv ./MOK.der $(modinfo -n $kernel_module)
    ```

    * `$kernel_module` should be the name of the module to sign, for exmaple `` (the virtual box driver module).

3. __Confirm__ the module is signed by checking the `modinfo` for `Module signature appended` annotation:

    ```bash
    tail $(modinfo -n $kernel_module) | grep "Module signature appended"
    ```

4. __Register__ the `public key` with `Secure Boot` so it can check the modules `authenticity`:

    ```bash
    sudo mokutil --import MOK.der
    ```

5. __Reboot__ the system, and, when prompted follow the instructions to __Enroll__ the key.

6. __Check__ the key is `enrolled`

    ```bash
    mokutil --test-key MOK.der
    ```

> Keep the `key pair` safe to allow it to be used to sign further modules or updates.

---

## References

* [Ubuntu Forum - vboxdrv](https://askubuntu.com/questions/760671/could-not-load-vboxdrv-after-upgrade-to-ubuntu-16-04-and-i-want-to-keep-secur/768310#768310)

* [Instructions (Systemtap)](https://sourceware.org/systemtap/wiki/SecureBoot)

* [Using UEFI in QEMU](https://fedoraproject.org/wiki/Using_UEFI_with_QEMU?rd=Testing_secureboot_with_KVM)