


#### HowTo: Get routing table with `ip` tool.

```
$> ip route
```
```
default via 192.168.0.1 dev wlp6s0 proto dhcp metric 600
10.192.0.0/24 dev br-bfb93eba60b4 proto kernel scope link src 10.192.0.1 linkdown
169.254.0.0/16 dev virbr0 scope link metric 1000 linkdown
172.17.0.0/16 dev docker0 proto kernel scope link src 172.17.0.1 linkdown
192.168.0.0/24 dev wlp6s0 proto kernel scope link src 192.168.0.7 metric 600
192.168.122.0/24 dev virbr0 proto kernel scope link src 192.168.122.1 linkdown
```

#### HowTo: Get routing table with `ip` tool.

```
netstat -r -n
```
```
Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
0.0.0.0         192.168.0.1     0.0.0.0         UG        0 0          0 wlp6s0
10.192.0.0      0.0.0.0         255.255.255.0   U         0 0          0 br-bfb93eba60b4
169.254.0.0     0.0.0.0         255.255.0.0     U         0 0          0 virbr0
172.17.0.0      0.0.0.0         255.255.0.0     U         0 0          0 docker0
192.168.0.0     0.0.0.0         255.255.255.0   U         0 0          0 wlp6s0
192.168.122.0   0.0.0.0         255.255.255.0   U         0 0          0 virbr0
```



#### HowTo: Get Gateway
```
ip route | grep default
```
```
default via 192.168.0.1 dev wlp6s0 proto dhcp metric 600
```

