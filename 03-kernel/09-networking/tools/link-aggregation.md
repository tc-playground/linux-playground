# Link Aggregation

## Introduction

Bonded/Teamed interfaces allow multiple links to behave like one single link to: 

* Aggregate the bandwidth of multiple links together or to simply 

* Provide fault tolerance against the failure of a single link.

There are 2 implementations in Linux: 

* `bonding` - Uses traditional linux bonding interface via a kernel module.

* `teaming` - Requires a `teamd` daemon to set things such as packet balancing policy.


> NB: Bonded interface are also through the terms: `teaming`, `LACP`, `802.3ad`, `link aggregation` and  `channel bonding`.

---

## Uses

* Provide redundant links to protect against the failure of a single link.

* Provide redundant links to different upstream switches to prevent failure of a single upstream switch making the host unavailable.

* Provide a higher bandwidth link made up from the aggregate of the links in the bonded interface.

* Assist in physical migration of hosts.

---

## References

* [Linux Networking: Bonded Interfaces and Vlans](http://www.pocketnix.org/posts/Linux%20Networking%3A%20Bonded%20Interfaces%20and%20Vlans)
* [How To Configure Network Teaming In Linux](https://www.rootusers.com/how-to-configure-network-teaming-in-linux/) - CentOS
* [Configure Network Bonding or Teaming](https://www.tecmint.com/configure-network-bonding-teaming-in-ubuntu/) - Ubuntu
* [How To Configure Network Teaming In Linux](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-configure_a_network_team_using-the_command_line) - RHEL