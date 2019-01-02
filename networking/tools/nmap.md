PARTIAL-STUB
# nmap

## Example - Find all devices on local network.

### Extract LAN CIDR Range.

```
ifconfig
```

### Extract Interface, IP, and Netmask of LAN.

```
wlp6s0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.0.6  netmask 255.255.255.0  broadcast 192.168.0.255
        inet6 fe80::57bc:9fe8:d14c:a4df  prefixlen 64  scopeid 0x20<link>
        ether 38:de:ad:49:51:9c  txqueuelen 1000  (Ethernet)
        RX packets 112785  bytes 115128147 (115.1 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 54296  bytes 10673019 (10.6 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

```
sudo nmap -sn 192.168.0.6/24
```
```
Starting Nmap 7.60 ( https://nmap.org ) at 2018-12-17 23:17 GMT
Nmap scan report for routerlogin.net (192.168.0.1)
Host is up (0.0057s latency).
MAC Address: 20:0C:C8:5B:D8:4F (Netgear)
Nmap scan report for 192.168.0.2
Host is up (0.068s latency).
MAC Address: 54:60:09:7F:9A:42 (Google)
Nmap scan report for 192.168.0.3
Host is up (0.069s latency).
MAC Address: A4:77:33:6F:A5:FC (Google)
Nmap scan report for 192.168.0.4
Host is up (0.0076s latency).
MAC Address: 88:71:E5:BD:8C:41 (Amazon Technologies)
Nmap scan report for 192.168.0.5
Host is up (0.065s latency).
MAC Address: B4:F1:DA:B5:8F:2C (Unknown)
Nmap scan report for 192.168.0.9
Host is up (0.0060s latency).
MAC Address: 70:4F:B8:FE:7C:ED (Unknown)
Nmap scan report for 192.168.0.10
Host is up (0.061s latency).
MAC Address: 80:EA:23:20:D6:BC (Wistron Neweb)
Nmap scan report for occam (192.168.0.6)
Host is up.
Nmap done: 256 IP addresses (8 hosts up) scanned in 2.42 seconds
```

---

#### References
* [Home Page](https://nmap.org/)
* [Man page](https://nmap.org/book/man.html)
* [Nmap Book](https://nmap.org/book/toc.html)