#!/bin/bash

shopt -s expand_aliases

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# References ==================================================================
#
# * https://www.cyberciti.biz/tips/compiling-linux-kernel-26.html
# * https://unix.stackexchange.com/questions/115620/configuring-compiling-and-installing-a-custom-linux-kernel

# Build Linux Kernel ==========================================================
#

[ -z "${KERNEL_VERSION}" ] && export KERNEL_VERSION="linux-4.20"
[ -z "${BUILD_PATH}" ] && export BUILD_PATH="${DIR}/kernel-builds"
[ -z "${CUSTOMISE_KERNEL}" ] && export CUSTOMISE_KERNEL="false"

# Install the require tools to build the kernel.
function kernel::install-tools() {
    # NB: Add 'libc6-dev-i386' to add 32-0biut support for building 32 bit kernels.
    sudo apt install build-essential libncurses-dev bison flex libssl-dev libelf-dev 
}

# Download the specified kernel version source archive.
function kernel::get-source() {
    local version="${1-${KERNEL_VERSION}}"
    local url="https://cdn.kernel.org/pub/linux/kernel/v4.x"

    # Move to the target 'build' directory.
    mkdir -p "${BUILD_PATH}" && pushd "${BUILD_PATH}"

    # If the kernel source archive does not exist; then download it. 
    if [ ! -f "${version}.tar.xs" ]; then
        curl -O "${url}/${version}.tar.xz"
        xz -d -v "${version}.tar.xz"
    fi

    # If the kernel source archive signature does not exist; then download it and the key. 
    if [ ! -f "${version}.tar.sign" ]; then
        curl -O "${url}/${version}.tar.sign"
        rsa_key=$(gpg --verify ${version}.tar.sign 2>&1 >/dev/null | grep 'using RSA key' | awk '{print $NF}')
        gpg --recv-keys "${rsa_key}"
    fi

    # Validate the source archive; if it fails then exit.
    bad_signature=$(gpg --verify ${version}.tar.sign 2>&1 >/dev/null | grep 'BAD signature')
    if [ ! -z "${bad_signature}" ]; then
        gpg --verify ${version}.tar.sign
        echo "GPG check failed with a 'BAD signature'. Aborting."
        popd && exit 1
    fi

    # Unpack the archive and exit.
    if [ ! -d "${version}." ]; then
        tar xvf "${version}.tar" 
    fi
    
    popd
}

# Clean the kernel source. This will destroy everything!
function kernel::delete-source {
    local version="${1-${KERNEL_VERSION}}"
    rm -R "${BUILD_PATH}/${version}"
}

# Build a default Linux kernel,
function kernel::build {
    local version="${1-${KERNEL_VERSION}}"
    pushd "${BUILD_PATH}/${version}"
    echo "$PWD"
    # Take the default confi for this architecture.
    cp -v /boot/config-$(uname -r) .config
    # If specified, customise the kernel. 
    if [ "${CUSTOMISE_KERNEL}" == "true" ]; then
        make menuconfig
    fi
    # Build the kernel.
    make -j 4
    popd
}

# Install Linux kernel,
function kernel::install {
    # Install linux kernel modules.
    sudo make modules_install
    # Install the kernel.
    sudo make install
}


# Miscellaneous ===============================================================
#

# Help for 'kernel' script.
function  kernel::help() {
    echo
    echo "*** Commands ***"
    echo
    echo "install-tools           : Install the OS kernel build tools (apt only)."
    echo "get-source    <version> : Get the kernel source (for the specified version)."
    echo "delete-source <version> : Delete the kernel source (for the specified version)."
    echo "build         <version> : Build the kernel source (for the specified version)."
    echo
    echo "*** ENVIRONMENT ***"
    echo
    echo "KERNEL_VERSION          : Define the kernel version (kernel.org)"
    echo "BUILD_PATH              : Define the local path of where to download and build the kernel."
    echo "CUSTOMISE_KERNEL        : If 'true' allow an attending user to configure the kernel before building."
    echo
}

function kernel::env() {
    echo
    echo "*** ENVIRONMENT ***"
    echo
    echo "KERNEL_VERSION   ${KERNEL_VERSION}"
    echo "BUILD_PATH       ${BUILD_PATH}"
    echo "CUSTOMISE_KERNEL ${CUSTOMISE_KERNEL}"
    echo
}

function kernel::load() {
    [[ "${BASH_SOURCE[0]}" == "${0}" ]] \
        && echo "The 'load' command must be 'sourced' when invoked." && exit 1
    local target="$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)/$(basename ${BASH_SOURCE[0]})"
    alias kernel="${target}"
}

function kernel::unload() {
    [[ "${BASH_SOURCE[0]}" == "${0}" ]] \
        && echo "The 'unload' command must be 'sourced' when invoked." && exit 1
    unalias kernel
}

if [ ! -z "$1" ]; then
    kernel::$*
fi
