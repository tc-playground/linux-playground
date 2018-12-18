# ARP (Address Resolution Protocol)

## Introduction

ARP stands for Address Resolution Protocol, which is used to find the media access control address of a network neighbour for a given IPv4 Address.

ARP can also be used to announce an IP/MAC mapping.

## Example

* Two machine on the same (Ethernet) LAN.
* The IP of a target machine is known (maybe via DNS), but, the source machine does not have the destination machines MAC address in it's arp cache.
* An ARP request is broadcast to all machines on the LAN with the IP of target destination machine, and it's own source IP and MAC addresses.
* The target machine responds with it's MAC and IP address to the broadcaster, which may add the mapping to it's arp cache.

## References
* [Address Resolution Protocol - Wikipedia](https://en.wikipedia.org/wiki/Address_Resolution_Protocol)
* `cat /etc/net/arp`
* `man arp`