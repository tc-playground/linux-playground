# iproute2

## Introduction

`iproute2` is a collection of _userspace_ utilities for controlling and monitoring various aspects of networking in the Linux kernel, including routing, network interfaces, tunnels, traffic control, and network-related device drivers.

`iproute2` utilities communicate with the Linux kernel using the `netlink` protocol. 

`iproute2` utilities are often recommended over now-obsolete `net-tools` utilities that provide the same functionality.

---

## Tools

`iproute2` contains the following command-line utilities: 

* `ip` - Manipulate routing, network devices, interfaces and tunnels.

* `ss` - A utility to dump socket statistics. It allows showing information similar to netstat. It can display more TCP and state informations than other tools.

* `bridge` - Manipulate bridge addresses and devices.

* `rtacct` - See `nstat`.

* `rtmon` - Listens on netlink socket and monitors routing table changes.

* `tc` - Manipulate traffic control settings.

* `ctstat` - See `lnstat`.

* `lnstat` - A generalized and more feature-complete replacement for the old `rtstat` program. It is commonly used to periodically print a selection of statistical values exported by the kernel. In addition to routing cache statistics, it supports any kind of statistics the linux kernel exports via a file in `/proc/net/stat/`.

* `nstat` - _nstat_ and _rtacct_ are simple tools to monitor kernel snmp counters and network interface statistics.

* `routef` - Flush (DELETE) routes. Beware! This means deleting all routes which will make your network unusable!

* `routel` - List routes with pretty output format.

* `rtstat` - See `lnstat`.

* `tipc` - A _Transparent Inter-Process Communication_ configuration and management tool. The TIPC protocol offers total address transparency between processes which allows applications in a clustered computer environment to communicate quickly and reliably with each other, regardless of their location within the cluster.

* `arpd` - Userspace `arp` daemon. The `arpd` daemon collects gratuitous ARP information, saving it on local disk and feeding it to the kernel on demand to avoid redundant broadcasting due to limited size of the kernel _ARP cache_.

* `devlink` - Tool for interacting with `devlink` devices. __NB__: `devlink` is a protocol to expose devices that do not belong to a specific linux `device class`.

---

## `iproute2` deprecations of `net-tools` 

| net-tool	 | iproute2                       | Notes                              |
| ---------- | ------------------------------ | ---------------------------------- |
| `arp`	     | `ip neigh`                     | Neighbors                          |
| `ifconfig` | `ip addr`, `ip link`, `ip -s`  | Address and link configuration     |
| `ipmaddr`	 | `ip maddr`                     | Multicast                          |
| `iptunnel` | `ip tunnel`                    | Tunnels                            |
| `route`	 | `ip route`                     | Routing tables                     |
| `nameif`	 | `ifrename`, `ip link set name` | Rename network interfaces          |
| `netstat`  |	`ip -s`, `ss`, `ip route`	  | Show various networking statistics |
| `mii-tool` | `ethtool`                      |                                    |

---

## Tutorials

* [`ip` cheatsheet](https://access.redhat.com/sites/default/files/attachments/rh_ip_command_cheatsheet_1214_jcs_print.pdf)
* [iproute HowTo](http://www.policyrouting.org/iproute2.doc.html)
* [Dummy Interfaces and Virtual Bridges](http://www.pocketnix.org/posts/Linux%20Networking:%20Dummy%20Interfaces%20and%20Virtual%20Bridges)

---

## References

* [Wikipedia](https://en.wikipedia.org/wiki/Iproute2)
* [Home](http://www.linuxfoundation.org/collaborate/workgroups/networking/iproute2)
* [Repo](https://git.kernel.org/pub/scm/network/iproute2/iproute2.git)
* [Ubuntu Package](https://packages.ubuntu.com/cosmic/iproute2)
* [Ubuntu Package - Files](https://packages.ubuntu.com/cosmic/amd64/iproute2/filelist)

---

## Auxillary References

* [Netlink - Wikipedia](https://en.wikipedia.org/wiki/Netlink)
