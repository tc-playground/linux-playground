# libteamutils

## Introduction

Tools to created and manage _teamed interfaces_ that are managed by the `teamd` daemon.

---

## Tools

* `/usr/bin/teamd` - A  daemon to manage team network devices using `libteam` to communicate with the kernel team device instance via `netlink` sockets.

* `/usr/bin/teamdctl` - A tool to interact with a running `teamd` instance. It defaults to using Unix Domain Sockets, but will fall back to using the D-Bus API if required.

* `/usr/bin/teamnl` - A tool enabling interaction with a team device via the team driver Netlink interface. This tools serves mainly for debugging purposes.

---

## References

* [How To Configure Network Teaming In Linux](https://www.rootusers.com/how-to-configure-network-teaming-in-linux/) - CentOS
* [Configure Network Bonding or Teaming](https://www.tecmint.com/configure-network-bonding-teaming-in-ubuntu/) - Ubuntu
* [How To Configure Network Teaming In Linux](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-configure_a_network_team_using-the_command_line) - RHEL