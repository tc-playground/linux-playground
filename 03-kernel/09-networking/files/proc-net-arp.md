# /proc/net/arp

## Introduction

The `/proc/net/arp` file displays the 'arpcache' stored or computed by the kernel. 

To modify the cache the `arp` command should be used.

## Example

```
$> cat /proc/net/arp
```
```
IP address       HW type     Flags       HW address            Mask     Device
104.197.3.80     0x1         0x0         00:00:00:00:00:00     *        virbr0
104.197.3.80     0x1         0x0         00:00:00:00:00:00     *        enp5s0
192.168.0.10     0x1         0x2         80:ea:23:20:d6:bc     *        wlp6s0
104.198.143.177  0x1         0x0         00:00:00:00:00:00     *        docker0
104.198.143.177  0x1         0x0         00:00:00:00:00:00     *        enp5s0
192.168.0.2      0x1         0x2         54:60:09:7f:9a:42     *        wlp6s0
104.197.3.80     0x1         0x0         00:00:00:00:00:00     *        br-bfb93eba60b4
192.168.0.3      0x1         0x2         a4:77:33:6f:a5:fc     *        wlp6s0
104.198.143.177  0x1         0x0         00:00:00:00:00:00     *        br-bfb93eba60b4
104.198.143.177  0x1         0x0         00:00:00:00:00:00     *        eno1
192.168.0.9      0x1         0x2         70:4f:b8:fe:7c:ed     *        wlp6s0
104.197.3.80     0x1         0x0         00:00:00:00:00:00     *        eno1
104.197.3.80     0x1         0x0         00:00:00:00:00:00     *        docker0
104.198.143.177  0x1         0x0         00:00:00:00:00:00     *        virbr0
192.168.0.1      0x1         0x2         20:0c:c8:5b:d8:4f     *        wlp6s0
```

## References
* `man arp`