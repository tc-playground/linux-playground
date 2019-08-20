#!/bin/bash

# ip -h

# 1. Create and list new network namespace. 
NS="trjl-ns"
sudo ip netns add "${NS}"
# ip netns list
# sudo ip netns delete "${NS}"

# 2. Create a new veth pair (both in the global network namespace).

VETH1="trjl-veth-01"
VETH2="trjl-veth-02"
sudo ip link add "${VETH1}" type veth peer name "${VETH2}"
# ip link list | grep trjl

# 3. Connect the global ne namespace to the trjl-ns namespace.
ip link set "${VETH1}" netns "${NS}"

# 4. VETH1 should no longer be in the global network namespace.
# 
# ip link list | grep trjl

# 5. VETH1 should now be in the $NS network namespace.
# NB: To see this we need to 'exec' into the namespace.
# 
#  sudo ip netns exec "${NS}" ip link list | grep trjl

# 6. Assign an IP address to the veth1 interface and bring that interface up.
IP="10.1.1.1"
SUBNET_CIDR="${IP}/24"
# sudo ip netns exec "${NS}" ifconfig "${VETH1}" "${SUBNET_CIDR}" up
# Add the IP address to the VETH1 device
sudo ip netns exec "${NS}" ip addr add "${SUBNET_CIDR}" dev "${VETH1}"
sudo ip netns exec "${NS}" ip route add "${IP}"
sudo ip netns exec "${NS}" ip link set "${VETH1}" up # LOWERLAYERDOWN?

# 7. Tidy-up namespaces
sudo ip netns exec "${NS}" ip link set "${VETH1}" down
sudo ip netns exec "${NS}" ip route delete "${IP}"
sudo ip netns exec "${NS}" ip addr add "${SUBNET_CIDR}" dev "${VETH1}"
