# VLAN

## Introduction

* `VLANs`are a bit like `virtual switch`. 

* `VLANs` allow _multiple separate virtual networks_ to run on top of _single physical network_.

* `VLANs` augment network packets by adding additional `tags`. These are used to select packets for additional `L2` behaviour: `routing`, `traffic control`, etc.

* `VLANs` functionality can be implemented in hardware or software.

---

## Overview

* A `virtual LAN (VLAN)` is any broadcast domain that s partitioned and isolated in a computer network at the `data link layer` (`OSI layer 2`).

* `VLAN`s work by applying tags to network packets and handling these tags in networking systems – creating the appearance and functionality of network traffic that is physically on a single network but acts as if it is split between separate networks. In this way, VLANs can keep network applications separate despite being connected to the same physical network, and without requiring multiple sets of cabling and networking devices to be deployed.

* `VLAN`s allow network administrators to group hosts together even if the hosts are not directly connected to the same network switch.

* `VLAN`s allow networks and devices that must be kept separate to share the same physical cabling without interacting, improving simplicity, security, traffic management, or economy. 

    * For example, a VLAN could be used to separate traffic within a business due to users, and due to network administrators, or between types of traffic, so that users or low priority traffic cannot directly affect the rest of the network's functioning.

* Many Internet hosting services use VLANs to separate their customers' private zones from each other, allowing each customer's servers to be grouped together in a single network segment while being located anywhere in their data center. 

* Some precautions are needed to prevent traffic "escaping" from a given VLAN, an exploit known as `VLAN hopping`.

( To subdivide a network into `VLAN`s, one configures network equipment. Simpler equipment can partition only per physical port (if at all), in which case each VLAN is connected with a dedicated network cable. More sophisticated devices can mark frames through `VLAN tagging`, so that a single interconnect (trunk) may be used to transport data for multiple VLANs. 

* Since `VLAN`s share bandwidth, a `VLAN trunk` can use `link aggregation`, quality-of-service prioritization, or both to route data efficiently.

---

## Tutorials

* [VLAN tutorial](https://blog.sleeplessbeastie.eu/2012/12/23/debian-how-to-create-vlan-interface/)

---

## References

* [VLAN - Wikipedia](https://en.wikipedia.org/wiki/Virtual_LAN)

