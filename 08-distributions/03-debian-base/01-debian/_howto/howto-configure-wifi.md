# HowTo: Configure WiFi

---

## Tools

1. __Manual Tools__

    1. __Configuration__ - Debian 10 network configuration files:

        1. `/etc/network/interfaces`

        2. `/etc//network/interfaces.d/setup`

    2. `ip` - List network interfaces. Set ip, Set status. Etc.

        1. `sudo iwconfig` - Alternative. WiFi version of `ifconfig`.
    
    3. `iwlist` - Enumerate base stations and collect other information:

        1. `iwlist ${wiface} scan` - Scan for base stations.

    4. `wpa_cli` - Can be used to interact with a `base station` via a connected interface.

        1. Start Wi-Fi Protected Setup - `sudo wpa_cli wps_pbc ${BSSID}`
    
    5. `dhclient` - Can be used to get an `ip` after authorizing with `WPA`.

2. __Systemd Daemons__

    1. `wpa_supplicant` - Low level systemd WiFi support and tools package.

        1. `sudo systemctl status wpa_supplicant.service`

        2. `wpa_passphrase` - Generate a `PSK` for a specified `SSID` and `passphrase`.

3. __UI Tools__

    1. `Network Manager` - Desktop interface configuration.

    2. `Wicd (WiFi Connection Daemon)` - Alternative to `Network Manager`.

    3. `connman` - Alternative to `Network Manager`.

---

## References

* [WiFi Interface Configuration - Debian](https://wiki.debian.org/WiFi#Configure_Interface)

* [WiFi - Configuration HowTo - Debian](https://wiki.debian.org/WiFi/HowToUse)