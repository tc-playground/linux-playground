# ip

## Introduction

`ip` Manipulates routing, network devices, interfaces and tunnels.

The `ip` command manipulates various types of _network object_ in the linux network stack (e.g. `address`, `link` , `neighbor`, `route`, etc.). Each object can be acted upon with a set of (object specific) command verbs: _add_, _delete_, _set_, etc. with various options.

---

## Overview

## Objects

* `address` - Manage protocol (IP or IPv6) address on a device.

* `addrlabel` - Manage label configuration for protocol address selection.

* `l2tp` - Tunnel ethernet over IP (L2TPv3).

* `link` - Manage network device.

* `maddress` - Manage multicast address.

* `monitor` - Watch for netlink messages.

* `mroute` - Manage multicast routing cache entries.

* `mrule`  - Manage rules in multicast routing policy database.

* `neighbour` - Manage ARP or NDISC cache entries.

* `netns`  - Manage network namespaces.

* `ntable` - Manage the neighbor cache's operation.

* `route`  - Manage routing table entries.

* `rule`   - Manage rules in routing policy database.

* `tcp_metrics` - Manage TCP metrics.

* `token`  - Manage tokenized interface identifiers.

* `tunnel` - Tunnel over IP.

* `tuntap` - Manage TUN/TAP devices.

* `xfrm` - Manage `IPSec` policies.


> NB: More information can be be found by running `ip <object> help`.

---

## Tutorials

* [`ip` cheatsheet](https://access.redhat.com/sites/default/files/attachments/rh_ip_command_cheatsheet_1214_jcs_print.pdf)
* [`ip` networking commands](https://www.zframez.com/tutorials/linux-networking-commands.html)
* [HowTo - iproute2](http://www.policyrouting.org/iproute2.doc.html)

--- 

## References

* [Manual](http://linux-ip.net/gl/ip-cref/ip-cref-node19.html)

