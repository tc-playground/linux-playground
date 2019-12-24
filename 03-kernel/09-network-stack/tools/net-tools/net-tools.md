# net-tools

## Introduction

`net-tools` is a collection of _userspace_ utilities for controlling and monitoring various aspects of networking in the Linux kernel, including routing, network interfaces, tunnels, traffic control, and network-related device drivers.

`iproute2` utilities are often recommended over now-obsolete `net-tools` utilities that provide the same functionality.

---

## Tools

`net-tools` contains the following command-line utilities: 

* `arp` - Manipulates or displays the kernel's _IPv4 network neighbour_ cache. It can add entries to the table, delete one or display the current content.

* `hostname` - Display the system's DNS name, and to display or set its hostname or NIS domain name.

* `ifconfig` - Configure the kernel-resident network interfaces.  It is used at boot time to set up interfaces as necessary.  After that, it is usually only needed when debugging or when system tuning is needed.

* `ipmaddr` - 

* `iptunnel` - Used to add, change, delete and show IP tunnels on the machine.

* `mii-tool` - Checks or sets the status of a network interface's _Media Independent Interface_ (MII) unit.  Most fast ethernet adapters use an MII to  auto-negotiate link speed and duplex setting.

* `nameif` - Renames network interfaces based on mac addresses. When no arguments are given `/etc/mactab` is read.

* `netstat` - Display network connections, routing tables, interface statistics, masquerade connections, and multicast memberships. __NB__: `netstat` is deprecated: 
    * Replacement for `netstat` is `ss`.  
    * Replacement for `netstat -r` is `ip route`.
    * Replacement for  `netstat  -i`  is  `ip  -s  link`.
    * Replacement for `netstat -g` is `ip maddr`.

* `plipconfig` - Used improve _PLIP_ performance by changing the default timing parameters used by the PLIP protocol.

* `rarp` - Manipulate the system RARP table. __DEPRECATED__: From  version  2.3,  the  Linux  kernel  no longer contains RARP support.

* `route` - Manipulates the kernel's IP routing tables. Its primary use is to set up static routes to specific hosts or networks via an interface after it has been configured with the `ifconfig(8)` program. When the _add_ or _del_ options are used, route modifies the routing tables. Without these options, route displays the current contents of the routing tables.

* `slattach` - Used to put a normal terminal ("serial") line into one of several "network" modes, thus allowing you to use it for point-to-point links to other computers.

---

## `iproute2` deprecations of `net-tools` 

| net-tool	 | iproute2    |
| ---------- | ----------- |
| `arp`	     | `ip neigh`  |
| `ifconfig` | `ip addr`   |
| `ipmaddr`	 | `ip maddr`  |
| `iptunnel` | `ip tunnel` |
| `route`	 | `ip route`  |
| `nameif`	 | `ifrename`  |
| `mii-tool` | `ethtool`   |

---

## Tutorials

* [Interface configuration for IP](http://www.faqs.org/docs/linux_network/x-087-2-iface.interface.html)

---

## References

* [Home](http://net-tools.sourceforge.net/)
* [Ubuntu Package](https://packages.ubuntu.com/cosmic/net-tools)
* [Ubuntu Package - Files](https://packages.ubuntu.com/cosmic/amd64/net-tools/filelist)