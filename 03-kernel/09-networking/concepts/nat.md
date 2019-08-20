# NAT (Network Address Translation)

## Introduction

* `NAT` essentially allows a private network to communicate with the internet by keeping track of local ip addresses and ports (within the private network) and there connections to external ip addresses and ports. This is usually done at the gateway router.

* `NAT` can be implement in various ways using hardware or software.

* `NAT` has various substypes:
    * `SNAT (Source NAT)` - Change sender statically. TODO.
    * `MASQUERADE` - Change sender to router's IP address. TODO.
    * `DNAT (Destination NAT)` - Changing the recipients. TODO.
    * `REDIRECT` - Redirect packets to local machine. TODO.


STUB

## Tutorials

* [NAT Tutorial](https://www.karlrupp.net/en/computer/nat_tutorial)
* [Implementing a NAT with `iptables`](https://www.howtoforge.com/nat_iptables)
* [Implementing a NAT](http://etutorials.org/Networking/Check+Point+FireWall/Chapter+10.+Network+Address+Translation/Implementing+NAT+A+Step-by-Step+Example/)

---

## References

* [Wikipedia](https://en.wikipedia.org/wiki/Network_address_translation)
* [NAT - How Stuff Works](https://computer.howstuffworks.com/nat.htm)
