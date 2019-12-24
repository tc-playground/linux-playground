#!/bin/bash

# tcpdump =====================================================================
#
# A tool for inspecting and analysing network traffic.
# 
# Usage: tcpdump [-aAbdDefhHIJKlLnNOpqStuUvxX#] [ -B size ] [ -c count ]
#                 [ -C file_size ] [ -E algo:secret ] [ -F file ] [ -G seconds ]
#                 [ -i interface ] [ -j tstamptype ] [ -M secret ] [ --number ]
#                 [ -Q in|out|inout ]
#                 [ -r file ] [ -s snaplen ] [ --time-stamp-precision precision ]
#                 [ --immediate-mode ] [ -T type ] [ --version ] [ -V file ]
#                 [ -w file ] [ -W filecount ] [ -y datalinktype ] [ -z postrotate-command ]
#                 [ -Z user ] [ expression ]
# 
# PCAP Filters: port, portrange, host, src, dst, net, [protocol], less, greater...
#
# Logical Operators: && (and), || (or), ! (not).
#
# Basic Options: -w (write to pcap file), -r (read from pcap file), -i (interface).
#
# Advanced Options: 
#   -X : Show the packet’s contents in both hex and ascii.
#   -XX : Same as -X, but also shows the ethernet header.
#   -D : Show the list of available interfaces
#   -l : Line-readable output (for viewing as you save, or sending to other 
#        commands)
#   -q : Be less verbose (more quiet) with your output.
#   -t : Give human-readable timestamp output.
#   -tttt : Give maximally human-readable timestamp output.
#   -i eth0 : Listen on the eth0 interface.
#   -vv : Verbose output (more v’s gives more output).
#   -c : Only get x number of packets and then stop.
#   -s : Define the snaplength (size) of the capture in bytes. Use -s0 to get 
#        everything, unless you are intentionally capturing less.
#   -S : Print absolute sequence numbers.
#   -e : Get the ethernet header as well.
#   -q : Show less protocol information.
#   -E : Decrypt IPSEC traffic by providing an encryption key.
#   -n : Don't  convert  addresses  (i.e.,  host  addresses,  port numbers, 
#        etc.) to names.
#
# References
# * https://danielmiessler.com/study/tcpdump/
#
# =============================================================================

# Basic PCAP expression Filter ------------------------------------------------
#

# Watch raw traffic.
# 
# No resolution of hostnames, port numbers,etc.
# 
function net::tcpdump::watch_all_raw() {
    tcpdump -ttttnnvvS
}

# Watch traffic on port.
# 
function net::tcpdump::watch_port() {
    local port=$(1:-"443")
    tcpdump port "${port}"
}

# Watch traffic on port range.
# 
function net::tcpdump::watch_port_range() {
    local s_port=$(1:-"8080")
    local e_port=$(2:-"8081")
    tcpdump portrange "${s_port}-${e_port}"
}

# Watch traffic on interface.
# 
function net::tcpdump::watch_iface() {
    local iface=${1:-"all"}
    tcpdump -i "${iface}"
}

# Watch traffic for host IP.
# 
function net::tcpdump::watch_target_host() {
    local host_ip=${1:-"google.com"}
    tcpdump host "${host_ip}"
}

# Watch traffic from src IP.
# 
function net::tcpdump::watch_src_ip() {
    local src_ip=${1:-"127.0.0.1"}
    tcpdump src "${src_ip}"
}

# Watch traffic to dest IP.
# 
function net::tcpdump::watch_dst_ip() {
    local dst_ip=${1:-"google.com"}
    tcpdump dst "${dst_ip}"
}

# Watch traffic by network cidr range.
# 
function net::tcpdump::watch_dst_ip() {
    local new_cidr=${1:-"127.0.0.0/8"}
    tcpdump net "${nw_cdir}"
}

# Watch traffic by protocol.
# 
function net::tcpdump::watch_protocol() {
    local protocol=${1:-"icmp"}
    tcpdump "${protocol}"
}

# Main ========================================================================
#

if [ ! -z "$1" ]; then
    net::tcpdump::$*
fi



