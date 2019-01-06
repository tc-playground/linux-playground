# iptables

## Introduction

* `iptables` and `ip6tables` are used to set up, maintain, and inspect the `tables` of IPv4 and IPv6 `packet filter rules` in the Linux kernel.

* `iptables` can allow `firewalls` to be implemented.

* `iptables` can allow `NATs` to be implemented.

* `iptables` can allow `rate limiting` to be implemented.

* `iptables` can allow `user blocking` to be implemented.

---

## Overview

* All data is sent in the form packets over the internet. 

* `iptables` is just a command-line interface to the packet filtering functionality in netfilter.

* `iptables` is a stateful `firewall`.

* `iptables` packet filtering is organized into three different kinds of structures: `tables`, `chains` and `targets`. 

    *  `tables` - Allow you to process packets in specific ways:

        * There are 5 defaults tables: `filter` (default), `nat`, `mangle`, `raw`, and, `security`.

        * Have one or more `chains` attached to them

    * `chains` - Allow you to inspect and act on packets at various points during packet processing.

        * A chain is a set of rules.

        * When a packet arrives (or leaves, depending on the chain), `iptables` matches it against `rules` and takes the appropriate action.

        * `rules` - Are defined with respect to packet criteria, and, have a `target` (action):
        
            * `criteria` - Includes: source/destination ip, source dstination port, protocol, input/ouput interfaces, etc.

            * `connection state` - The history of the connection and who initiated it. 

            * `actions` - Includes ACCEPT, DROP, QUEUE, RETURN, LOG, etc.

---

## Tables

`tables` allow you to do very specific things with packets. On a modern Linux distributions, there are four tables:

* `filter` - This is the default and perhaps the most widely used table. It is used to make decisions about whether a packet should be allowed to reach its destination.

* `mangle` - This table allows you to alter packet headers in various ways, such as changing TTL values.

* `nat` - This table allows you to route packets to different hosts on NAT (Network Address Translation) networks by changing the source and destination addresses of packets. It is often used to allow access to services that can’t be accessed directly, because they’re on a NAT network.

* `raw`- iptables is a stateful firewall, which means that packets are inspected with respect to their “state”. (For example, a packet could be part of a new connection, or it could be part of an existing connection.) The raw table allows you to work with packets before the kernel starts tracking its state. In addition, you can also exempt certain packets from the state-tracking machinery.

* `security` - In addition, some kernels also have a security table. It is used by SELinux to implement policies based on `SELinux` security contexts.

---

## Chains

Now, each of these tables are composed of a few default chains. These chains allow you to filter packets at various points. The list of chains iptables provides are:

* `PREROUTING` - Apply to packets as they just arrive on the network interface. This chain is present in the `nat`, `mangle` and `raw` tables.

* `INPUT` - Rules in this chain apply to packets just before they’re given to a local process. This chain is present in the `mangle` and `filter` tables.

* `OUTPUT` - Apply to packets just after they’ve been produced by a process. This chain is present in the `raw`, `mangle`, `nat` and `filter` tables.

* `FORWARD`- Apply to any packets that are routed through the current host. This chain is only present in the `mangle` and `filter` tables.

* `POSTROUTING` - Apply to packets as they just leave the network interface. This chain is present in the `nat` and `mangle` tables.

### `iptables` packet filtering
<img src="iptables-filtering.png" 
    style="background-color: white; border-radius: 10px"/>

---

## Targets

`chains` allow you to filter traffic by adding `rules` to them. `targets` then decide the fate of a packet.

Some targets are `terminating`, which means that they decide the matched packet’s fate immediately: 

* `ACCEPT` - This causes `iptables` to __accept__ the packet.

* `DROP`  - This causes `iptables` to __drop__ the packet. To anyone trying to connect to your system, it would appear like the system didn’t even exist

* `REJECT` - This causes `iptables` __rejects__ the packet. It sends a “connection reset” packet in case of TCP, or a “destination host unreachable” packet in case of UDP or ICMP.

Some targets are `non-terminating`, which means that they keep matching other rules even if a match was found:

* `LOG` - This causes `iptables` to __log__ the packet. The information should be logged to `/var/log/syslog` (or `/var/log/messages`).

* `RETURN` - This causes `iptables` to return from this chain and continue processing from the next rule.

`custom chains` can also be created for complex rule-sets and these can be jumped to as a target.

> NB: There are further actions beyond these `QUEUE`, etc.


---

## Commands and Rules

* The `iptables` command can be used to view and modify the table chains:

    * `chains` are queried as follows:
        * `t` - Target chain on table. The default is the `filter` table.
        * `L` - List all chains.
        * `-v` - Verbose ouput.
        * `--line-numbers` - Used to include the rules index - this is used for operation on a specific rule.
        * `-N` - CCreate a new `custom chain`.
        * `-P` - Change the `default policy` (target) for a chain.
        * etc.

    * `rules` are added/deleted to `chains` via commands:
        * `-I` - Insert a rule (at top).
        * `-A` - Append a rule (at bottom).
        * `-D` - Delete a rule.
        * `-R` - Replace/Update a rule.
        * etc.

    * `criteria` is set for rules using options:
        * `-m`     - Match on `module` criteria.
        * `-p`     - Match on protocol.
        * `-i`     - Match on input interface.
        * `-o`     - Match on output interface.
        * `-s`     - Match on source ip.
        * `-d`     - Match on destination ipi.
        * `-sport` - Match on source port. (tcp module)
        * `-dport` - Match on destination port. (tcp module)
        * `!`      - Negation.
        * etc.

    * `target` is set for a rule using options:
        * `-j` - Set the `target`.

    Example:
    ```
    iptables -L --line-numbers
    iptables -t filter -A INPUT -s 59.45.175.62 -j REJECT
    iptables -D INPUT 2
    iptables -R INPUT 1 -s 59.45.175.10 -j ACCEPT
    ```

* The `iptables-save` command can be used to save te changes so they are persisted between reboots.


---

## Modules

`modules` allow further packet matching criteria to be specified. They are defined with `-m` option:

* __`tcp`__ - Allow source and destination ports in criteria:

    * `-sport` - Match on source port. (tcp module)

    * `-dport` - Match on destination port. (tcp module)

* __`multiport`__ - Allow multiple ports in criteria:

    * `-sports` - Match on source port. (tcp module)

    * `-dports` - Match on destination port. (tcp module)

* __`conntrack`__ - Allow _connection state_ in criteria: 

    * `NEW`: This state represents the very first packet of a connection.

    * `ESTABLISHED`: This state is used for packets that are part of an existing connection. For a connection to be in this state, it should have received a reply from the other host.

    * `RELATED`: This state is used for connections that are related to another `ESTABLISHED` connection. An example of this is a FTP data connection — they’re “related” to the already “established” control connection.

    * `INVALID`: This state means the packet doesn’t have a proper state. This may be due to several reasons, such as the system running out of memory or due to some types of `ICMP` traffic.

    * `UNTRACKED`: Any packets exempted from connection tracking in the raw table with the `NOTRACK` target end up in this state.

    * `DNAT`: This is a virtual state used to represent packets whose destination address was changed by rules in the `nat` table.

    * `SNAT`: Like `DNAT`, this state represents packets whose source address was changed.

* __`limit`__ - Place a limit to the number of packets passing through the network.
    * `iptables -A INPUT -p icmp -m limit --limit 1/sec --limit-burst 1 -j ACCEPT`
    * Cannot handle a dynamic, per IP restriction. 

* __`recent`__ - Place a limit to the number of packets from a specific ip.

* __`owner`__ - Block traffic on a per user basis.


---

## Tutorials - Simple

### Quick
* [Simple `iptables` Tutorial 1](https://www.hostinger.co.uk/tutorials/iptables-tutorial)
* [Simple `iptables` Tutorial 2](https://www.howtogeek.com/177621/the-beginners-guide-to-iptables-the-linux-firewall)

### Practical
* [`iptables` Overview](https://www.booleanworld.com/depth-guide-iptables-linux-firewall/)
* [`iptables` Common Commands](https://www.digitalocean.com/community/tutorials/iptables-essentials-common-firewall-rules-and-commands)

### In Depth
* [`iptables` Tutorial](https://www.frozentux.net/iptables-tutorial/iptables-tutorial.html)
* [`iptables` NAT Tutorial](https://www.karlrupp.net/en/computer/nat_tutorial)


---

## References

* [netfilter.org](https://netfilter.org/)
* [Home](https://netfilter.org/projects/iptables/index.html)
* [Man page](http://ipset.netfilter.org/iptables.man.html)
* [`iptables` filtering diagram](https://www.booleanworld.com/wp-content/uploads/2017/06/Untitled-Diagram.png)

* [Netfilter Extensions](https://www.netfilter.org/documentation/HOWTO/netfilter-extensions-HOWTO-3.html)
