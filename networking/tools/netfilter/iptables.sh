
#!/bin/bash

# References ==================================================================
#
# * https://www.hostinger.co.uk/tutorials/iptables-tutorial
# * https://www.digitalocean.com/community/tutorials/iptables-essentials-common-firewall-rules-and-commands


# Common functions ============================================================
#

# LIST all chains in filter table with line numbers. Line numbers serve as a 
# unique index to allow individual rules to be updated and deleted.
#
# '-L' to list all rules in target table (default: filter).
# '-v' for verbose mode.
# '--line-numbers' to include rule indexes.
function iptables::list-all() 
    sudo iptables -L -v --line-numbers
}

# LIST all chains in filter a sppecific table with line numbers. Line numbers serve as a 
# unique index to allow individual rules to be updated and deleted.
#
# '-t' to select a specific table: {filter (default), nat, mangle, raw, security, etc.}
# '-L' to list all rules in target table (default: filter).
# '-v' for verbose mode.
# '--line-numbers' to include rule indexes.
function iptables::list-all-for-table() 
    local table=$1
    sudo iptables -t "${table}" -L -v --line-numbers
}

# PERSIST all rules so that they persist over reboots.
#
function iptables::persist-rules() 
    sudo iptables-save
}

# Save
function iptables::save-rules() 
    sudo iptables-save > iptables.rules
}

# Load
function iptables::load-rules() 
    sudo iptables-restore < iptables.rules
}

# Firewall functions ==========================================================
#

# ACCEPT/ENABLE local traffic.
#
# '-A' to append rule to INPUT chain.
# '-i' to define the input 'interface' in the rule.
# '-j' to define the 'target' of the rule.
function iptables::enable-local-traffic() {
    sudo iptables -A INPUT -i lo -j ACCEPT
}

# ACCEPT/ENABLE SSL, HTTP, SSH port in the firewall.
#
# '-A' to append rule to INPUT chain.
# '-p' to define 'protocol' in rule..
# '-dport' to define 'destination port' in rule.
# '-j' to define the 'target' of the rule.
function iptables::enable-ssl-http-ssh-default-ports() {
    # SSL
    sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
    # HTTP
    sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
    # SSH
    sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
}

# ACCEPT packets from source ip/cidr-range.
#
# '-A' to append rule to INPUT chain.
# '-s' to define 'source address' in rule.
# '-j' to define the 'target' of the rule.
function iptables::accept-packets-by-source() {
    local ip_cidr=$1
    sudo iptables -A INPUT -s "${ip_cidr}" -j ACCEPT
}

# BLOCK/DROP packets from source ip/cidr-range.
#
# '-A' to append rule to INPUT chain.
# '-s' to define 'source address' in rule.
# '-j' to define the 'target' of the rule.
function iptables::drop-packets-by-source() {
    local ip_cidr=$1
    sudo iptables -A INPUT -s "${ip_cidr}" -j DROP
}

# BLOCK/REJECT packet from source ip/cidr-range.
#
# '-A' to append rule to INPUT chain.
# '-s' to define 'source address' in rule.# '-j' to define the 'target' of the rule.
function iptables::reject-packets-by-source() {
    local ip_cidr=$1
    sudo iptables -A INPUT -s "${ip_cidr}" -j REJECT
}

# BLOCK/DROP ALL packets. This should be the FINAL rule of the INPUT chain.
#
# '-A' to append rule to INPUT chain.
# '-j' to define the 'target' of the rule.
function iptables::drop-all-packets() {
    sudo iptables -A INPUT -j DROP
}

# DLETE ALL EWARNING! Remove all rules, from all chains.
#
# '-F' to delete all rules.
function iptables::clean() {
    sudo iptables -F
}

# DELETE dilter table input chain rule by ID.
#
# '-F' to delete a rule by index.
function iptables::delete() {
    local iax=$1
    sudo iptables -D INPUT "${idx}"
}

# Advanced Firewall functions =================================================
#

# ACCEPT loopback connections by enabling 'lo' interface on BOTH INPUT
# and OUPUT chains of the filter table.
#
# '-A' to append rule to chain.
# '-i' to define the 'input interface' in the rule.
# '-i' to define the 'output interface' in the rule.
# '-j' to define the 'target' of the rule.
function iptables::allow-loopback-connections() {
    sudo iptables -A INPUT -i lo -j ACCEPT
    sudo iptables -A OUTPUT -o lo -j ACCEPT
}

# ALLOW/ACCEPT related outgoing/incoming traffic.
#
# As network traffic generally needs to be two-way (incoming and outgoing) to work 
# properly, it is typical to create a firewall rule that allows established and 
# related incoming traffic, so that the server will allow return traffic to 
# outgoing connections initiated by the server itself.
#
# '-m' to define the rule to use the 'conntrack' connection tracking module.
# '--ctstate' to define the permitted conntection tracking states.
function iptables::allow-established-and-releated-incoming-connections() {
    sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
}

# ALLOW/ACCEPT outgoing traffic of all established connections, which are typically 
# the response to legitimate incoming connections.
#
# '-m' to define the rule to use the 'conntrack' connection tracking module.
# '--ctstate' to define the permitted conntection tracking states.
function iptables::allow-outgoing-established-connections() {
    sudo iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT
}

# ALLOW/ACCEPT from an internal network to an external network.
function iptables::allow-internal-to-external-connections() {
    local external-nw-iface=$1
    local internal-nw-iface=$2  
    sudo iptables -A FORWARD -i "${internal-nw-iface}" -o "${external-nw-iface}" -j ACCEPT
}

# DROP invalid packets.
function iptables::drop-invalid-packets() {
    sudo iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
}

# LOG invalid packets.
function iptables::drop-invalid-packets() {
    sudo iptables -A INPUT -m conntrack --ctstate INVALID -j LOG
}

# Module ======================================================================
#

function iptables::load() {
    [[ "${BASH_SOURCE[0]}" == "${0}" ]] \
        && echo "The 'load' command must be 'sourced' when invoked." && exit 1
    local target="$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)/$(basename ${BASH_SOURCE[0]})"
    alias iptables="${target}"
}

function iptables::unload() {
    [[ "${BASH_SOURCE[0]}" == "${0}" ]] \
        && echo "The 'unload' command must be 'sourced' when invoked." && exit 1
    unalias iptables
    unset -v $(env | grep IP_TABLES | cut -d'=' -f1 | xargs)
    unset -f $(declare -F | grep 'iptables::' | awk '{print $NF}' | xargs)
}

function iptables::reload() {
    local module="$(alias | grep 'iptables=' | cut -d'=' -f2 | xargs)"
    . "${module}" unload
    . "${module}" load
}

if [ ! -z "$1" ]; then
    uml::$*
fi