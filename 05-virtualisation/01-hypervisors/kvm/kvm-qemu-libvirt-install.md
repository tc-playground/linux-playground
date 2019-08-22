# KVM + QEMU + libvirt Install

---

## Ubuntu

## apt install
```
sudo apt install -y qemu-kvm
sudo apt install -y libvirt-clients libvirt-daemon-system virt-manager
sudo apt install -y bridge-utils

```

## Add user to groups [if required]

```
sudo adduser $(whoami) libvirt
sudo adduser $(whoami) libvirt-qemu
```

---

## References

* [Ubuntu Installation](https://linuxconfig.org/install-and-set-up-kvm-on-ubuntu-18-04-bionic-beaver-linux)