# HowTo: Instal KVM and QEMU

## Steps

1. __Install__ `qemu`, `kvm`, and ensure `vhost_net` kernel module is loaded 

```
sudo apt -y install qemu-kvm libvirt-daemon  bridge-utils virtinst libvirt-daemon-system
sudo modprobe vhost_net
```

2. __Install__ additional `virt` tools. 

```
sudo apt -y install virt-top libguestfs-tools libosinfo-bin  qemu-system virt-manager
```

```
qemu-img -h
qemu-system-x86_64 -h
```

---

## References

* [KVM - Debian](https://wiki.debian.org/KVM)

* [QEMU - Debian](https://wiki.debian.org/QEMU)

* [Debian KVM Install](https://computingforgeeks.com/how-to-install-kvm-virtualization-on-debian)

    * [Minimal Debian Install](https://www.howtoforge.com/tutorial/debian-minimal-server)