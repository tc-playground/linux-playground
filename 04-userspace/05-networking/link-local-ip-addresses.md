# Link Local IP Addresses

## Introduction

* In a `computer network`, a `link-local address` is a network address that is valid only for communications within the `network segment` or the `broadcast domain` that the host is connected to.

    * `RFC 3927`, reserves the IPv4 address block `169.254.0.0/16` (`169.254.0.0` – `169.254.255.255`) for __link-local addressing__.

        * NB: `169.254.0.0/24` and `169.254.255.0/24` are reserved and excluded from this.

* The main purpose for `link local` addresses is for providing `internal private ips` within a `network segment` / `broadcast domain`.

* This can include `physical` and `virtual` network devices.

---

## References

* [Link Local Address](https://en.wikipedia.org/wiki/Link-local_address) - A reserved portion of ip addresses intended to be dynamically provision for a network segment  (e.g. `LAN`_ by `APIPA`, `dhcp` or some other protocol. __Network auto-configuration__.

    * These addresses should not be routed out of the network.

    * Interfaces local to the network segment should always be reachable.

    * Reserved for `automatic private ip addressing` or `APIPA`.

* [Network Segment](https://en.wikipedia.org/wiki/Network_segment) - A portion of a computer network.

* [Broadcast Domain](https://en.wikipedia.org/wiki/Broadcast_domain) - a logical division of a computer network, in which all nodes can reach each other by broadcast at the data link layer. A broadcast domain can be within the same LAN segment or it can be bridged to other LAN segments. 

* []()

* [Dynamic Configuration of IPv4 Link-Local Addresses - RFC-3027](https://tools.ietf.org/html/rfc3927)
