# How to analyse the local network segment

## Introduction

* How to find information about a machine local or internal networking configuration.

---

## Check Local Machine Interfaces

## 1. Find local machine interfaces using `ip addr`

```bash
ip addr
```

> NB: Also, `ifconfig`.

## 2. List local machine open TCP sockets

```bash
sudo lsof -Pi -n | grep LISTEN
```

---

## Check Local Machine Outbound Routes

### 1. Find outbound (default) `routes` using `ip route list`

```bash
ip route list
```

---

## Check Local Machines DNS Configuration

### 1. Check DNS Server and Local Overrides

```bash
cat /etc/resolv.conf
```

### 2. Resolve an IP address using `getent`

```bash
getent hosts $domain_name | awk '{ print $1 }'
```

### 3. Resolve an IP address using `dig`

```bash
dig +short $domain_name
```

### 3. Resolve an IP address using `host`

```bash
host $domain_name
```

---

## Analyse Local Network Segment

### 1. Find local nw ip addresses using `arp`

```bash
arp -a
```

###  2. Scan for local nw ip addresses using `nmap` (ping scan)

```bash
nmap -sn 192.168.1.0/24
```

### 3. Check if address is reachable using `ping`

```bash
ping [$ip | $domain_name]
```

### 4. Check if address is reachable using `traceroute`

```bash
traceroute [$ip | $domain_name]
```

### 5. Find `dhcp` ip leases (requires access to dhcp server)

```bash
cat /var/lib/dhcpd/dhcpd.leases
```

---

## References





