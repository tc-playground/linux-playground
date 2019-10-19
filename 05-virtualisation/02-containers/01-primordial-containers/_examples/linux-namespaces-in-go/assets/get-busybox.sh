#!/bin/bash

# https://github.com/teddyking/ns-process
# 
# Get the 'busybox' tar.
# 
function install() {
    local _dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
    local binary="${_dir}/busybox.tar"
	if [ ! -f "${binary}" ]; then 
        wget https://github.com/teddyking/ns-process/blob/master/assets/busybox.tar
    fi
}

$@