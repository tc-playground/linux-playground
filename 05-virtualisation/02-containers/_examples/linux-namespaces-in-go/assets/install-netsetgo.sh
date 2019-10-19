#!/bin/bash

# https://github.com/teddyking/netsetgo
# 
# A utilty to program that helps to setup Network namespaces for containers:
# 
#   1. Creates a new network __bridge__. (netlink.LinkAdd).
#   2. Creates a __veth__ interface. (netlink.LinkAdd).
#   3. Attaches the  veth interface to the bridge. (netlink.LinkSetMaster).
#   4. Moves the veth interface to the new __namespace__. (netlink.LinkSetNsPid).
#   5. Add a default route to the new Network namespace. (netlink.RouteAdd(.) 
#
# NB: The binary is owned by root as iq requires root privileges, but, has the 
#     __setuid__ bit set to allow other users to execute it. 
# 
function install() {
    local _dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
    local binary="${_dir}/netsetgo"
	if [ ! -f "${binary}" ]; then 
        wget https://github.com/teddyking/netsetgo/releases/download/0.0.1/netsetgo -o "${binary}"
    fi
    sudo chown root:root /usr/local/bin/netsetgo    
	sudo chmod 4755 "${binary}"
}

function configure-internet-routing() {
    sudo iptables -tnat -N netsetgo
    sudo iptables -tnat -A PREROUTING -m addrtype --dst-type LOCAL -j netsetgo
    sudo iptables -tnat -A OUTPUT ! -d 127.0.0.0/8 -m addrtype --dst-type LOCAL -j netsetgo
    sudo iptables -tnat -A POSTROUTING -s 10.10.10.0/24 ! -o brg0 -j MASQUERADE
    sudo iptables -tnat -A netsetgo -i brg0 -j RETURN
    # NB: If required, remember to configure DNS inside container!
    # echo "nameserver 8.8.8.8" >> /etc/resolv.conf
}

$@
