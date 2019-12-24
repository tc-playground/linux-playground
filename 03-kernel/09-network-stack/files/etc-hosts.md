# /etc/hosts

## Introduction

A file that act as a first mapping for IP to hostname resolution. This can be used to provided simple domain name resolution without the need for DNS.

## Example

```
$> cat /etc/hosts
```
```
127.0.0.1       localhost
127.0.1.1       occam
127.0.0.1       memoria

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
```

## References
* `man hosts`