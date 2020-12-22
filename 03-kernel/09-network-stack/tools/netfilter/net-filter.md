# netfilter

## Introduction

* `netfilter` is a set of hooks inside the Linux kernel that allows kernel modules to register callback functions with the network stack. A registered callback function is then called back for every packet that traverses the respective hook within the network stack.

* `iptables` is a generic table structure for the definition of rulesets. Each rule within an IP table consists of a number of classifiers (iptables matches) and one connected action (iptables target).

* `netfilter`, `ip_tables`, connection tracking (`ip_conntrack`, `nf_conntrack`) and the `NAT` subsystem together build the major parts of the framework.

---

## Resources

* [Home](https://netfilter.org)

* [Netfilter Extensions](https://www.netfilter.org/documentation/HOWTO/netfilter-extensions-HOWTO-3.html)