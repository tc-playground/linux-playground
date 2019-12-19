# Full Disk Encryption

1. `Linux Unified Key Setup (LUKS)` - A mechanism for `full disk encryption`.

2. `LUKS` works at the `kernel level` - via the `device mapper`.

3. For `full disk encryption` the `bootloader` will need to decrpyt the disk before the kernel can be loaded.

4. The `cryptsetup` utility can be used to manage encrypted devices:

    * e.g. `cryptsetup luksDump /dev/xvda5` 

---

## References

* [LUKS - Wikipedia](https://en.wikipedia.org/wiki/Linux_Unified_Key_Setup)

* [Github](https://gitlab.com/cryptsetup/cryptsetup)

* [Redhat Guide](https://access.redhat.com/solutions/100463)

* [Youtube Tutorial](https://www.youtube.com/watch?v=5rlZtasM-Pk)

* [Slow Disk Unencyption on Boot](https://forum.manjaro.org/t/very-slow-disk-decryption-at-boot/19856/3)