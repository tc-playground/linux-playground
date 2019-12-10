# Howto: Alter Kernel bootloader parameters

## Steps

### 1. Dynamic Configuration

1. If necessary; `hold right-shift` during boot to enter the `boot menu`.

2. Select the boot option to edit and press `e`.

3. Edit the options as required. For example; remove `quiet` and `splash`.

4. Press `x` to continue booting.


### 2. Permanent Configuaration

1. Open the `GRUB` configuration file in `admin` mode: `sudo vim /etc/default/grub`

2. Make the required parameter changes.

3. Update `GRUB`: `sudo update-grub`.