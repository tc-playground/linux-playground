#!/bin/bash

# host ========================================================================
#
# A tool for resolving a hostnmae to IP or vice-versa.
#
# Usage: host [-aCdilrTvVw] [-c class] [-N ndots] [-t type] [-W time]
#             [-R number] [-m flag] hostname [server]
#        -a is equivalent to -v -t ANY
#        -c specifies query class for non-IN data
#        -C compares SOA records on authoritative nameservers
#        -d is equivalent to -v
#        -i IP6.INT reverse lookups
#        -l lists all hosts in a domain, using AXFR
#        -m set memory debugging flag (trace|record|usage)
#        -N changes the number of dots allowed before root lookup is done
#        -r disables recursive processing
#        -R specifies number of retries for UDP packets
#        -s a SERVFAIL response should stop query
#        -t specifies the query type
#        -T enables TCP/IP mode
#        -v enables verbose output
#        -V print version number and exit
#        -w specifies to wait forever for a reply
#        -W specifies how long to wait for a reply
#        -4 use IPv4 query transport only
#        -6 use IPv6 query transport only
# 
# =============================================================================

function net::host::resolve() {
    local host_or_ip=${1:-"google.com"}
    echo "host resolving: ${host_or_ip}"
    host "${host_or_ip}"
}