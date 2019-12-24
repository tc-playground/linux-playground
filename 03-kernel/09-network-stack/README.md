# Networking

---

## Architecture

### OSI Model (7-Layer)

### TCP/IP Model (5-Layer)

---

## Physical Networking
---

## Ethernet Networking - L2

### __Encapsulation__:  [Ethernet Frame](https://en.wikipedia.org/wiki/Ethernet_frame).
* __Preamble__: 7 octets.
* __Start Frame Delimiter__: 1 octet.
* __Source MAC address__: 6 octets,
* __Destination MAC address__: 6 octets.
* __802.1Q tag (optional)__: 4 octets.
* __Ethertype (Ethernet II) or length (IEEE 802.3)__: 2octets.	
* __Payload__: 46‑1500 octets.
* __32 Bit CRC__: 4 octets.
* __Interpacket gap__: 12 octets.


### __Addressing__: MAC address, Arp protocol.

#### Notes
> Higher level IP packets are split into 'Ethernet Frames' and broadcast for local delivery. They will either be accepted by a machine on the local network; or, the parts of a L3 packet collated and forwarded on by the network gateway (machine/switch/router).


---

## TCP/IP and UDP Networking - L3

* __Encapsulation__ : Packet
* __Addressing__ : IP

---

## IP (Internet Protocal) Routing -L3

---

### DNS (Domain NAme System)

---

### HTTP (HyperText Transfer Protocol) - L7

---

### SSL/TLS (Secure Socket Layer/Transport Layer Security)

---

### SMTP (Simple Mail Transfer Protocol)



