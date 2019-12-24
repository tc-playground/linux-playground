# brctl

## Introduction

__brctl__ is used to set up, maintain, and inspect the (virtual) ethernet bridge configuration in the linux kernel.

---

## Overview

### Bridges

A __bridge__ is a device commonly used to connect different (virtual) networks of ethernets together, so that these ethernets will appear as one ethernet to the participants.

Each of the ethernets being connected corresponds to one physical interface in the bridge. These individual ethernets are bundled into one bigger ('logical') ethernet, __this bigger ethernet corresponds to the bridge network interface__.

> Summary: A (virtual) bridge can be used to join several ethernets into one single logical network.

### Ports and Interfaces

Each bridge has a number of ports attached to it. Network traffic coming in on any of these ports will be forwarded to the other ports transparently, so that the bridge is invisible to the rest of the network (i.e. it will not show up in `traceroute(8)`).

The command `brctl addif <brname> <ifname>` will make the interface `<ifname>` a port of the bridge `<brname>`. This means that all frames  received on `<ifname>`  will  be  processed as if destined for the bridge. Also, when sending frames on `<brname>`, `<ifname>` will be considered as a potential output interface.

> Summary: A (virtual) bridge 'port' maps to an ethernet 'MAC addresses' of NICs on the network. The are stored in a __Forwarding database (fdb)__.

### Forwarding Database and Ageing

The bridge keeps track of the ethernet MAC addresses seen on each port (__fdb - forwarding database__). When it needs to forward a frame, and it happens to know on which port the destination MAC address (specified in the frame) is located, it can 'cheat' by forwarding the frame to that port only, thus saving a lot of redundant copies and transmits.

However, the ethernet address location data is not static data. Machines can move to other ports, network cards can be replaced (which  changes the machine's ethernet address), etc. The lifetime of entries in the fdb can be controlled with the `brctl  setageing <brname> <time>` and `brctl setgcint <brname> <time>` commands.

> Summary: A (virtual) bridges forwarding database entries lifetime can be configured.

### Multi-bridge Networks and the Spanning Tree Protocol

Multiple ethernet bridges can work together to create even larger networks of ethernets using the IEEE 802.1d spanning tree protocol. This protocol is used for finding the shortest path between two ethernets and for eliminating loops from the topology.

Bridges communicate with each other by sending and receiving __BPDUs__ (Bridge Protocol Data Units). These BPDUs can be recognised by an ethernet MAC destination address of `01:80:c2:00:00:00`.

---

## Usage

### Bridge Commands
* __List bridge devices__  - `brctl show`
* __Get bridge devices__   - `brctl show <brname>` 
* __Create bridge device__ - `brctl addbr <brname>`
* __Delete bridge device__ - `brctl delbr <brname>`

### Bridge Interface Commands
* __Create/Add interface to bridge__ - `brctl addif <brname> <ifname>`
* __Delete/Remove interface to bridge__ - `brctl delif <brname> <ifname>`

### Bridge Forwarding Database Commands
* __List the Forwarding Database MAC Addresses__ - `brctl showmacs <brname>`
* __Set the MAC address ageing time__ - `brctl setageing <brname> <time>`
* __Set the MAC address garbage collection interval__ - `brctl setgcint <brname> <time>`

### Bridge STP Configuration Commands
* __Enable/Disable STP__ - `brctl  stp  <bridge> [on|off]`
* __Set bridge priority__ - `brctl setbridgeprio <bridge> <priority>`

---

## References
* __Man page__ - `man brctl`

