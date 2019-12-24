#!/bin/bash

# ipcalc ======================================================================
#
# A tool for analysing IP CIDR ranges.
#
# =============================================================================

function net::calc::analyse() {
    local cidr=${1:-"127.0.0.1/32"}
    echo "ipcalc analysing: ${cidr}"
    tcpdump -i "${cidr}"
}