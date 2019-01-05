#!/bin/bash

# References ==================================================================
#
# * https://opensourceforu.com/2016/11/discovering-versatility-user-mode-linux/
# * https://www.cyberciti.biz/tips/compiling-linux-kernel-26.html


# Build UML ===================================================================
#

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

[ -z "${UML_HOME}" ] && export UML_HOME="${HOME}/virt-uml"
[ -z "${UML_BUILD}" ] && export UML_BUILD="${UML_HOME}/build"
[ -z "${UML_KERNELS}" ] && export UML_KERNELS="${UML_HOME}/kernels"
[ -z "${UML_FILESYSTEMS}" ] && export UML_FILESYSTEMS="${UML_HOME}/filesystems"
[ -z "${UML_ENVIRONMENTS}" ] && export UML_ENVIRONMENTS="${UML_HOME}/environments"

[ -z "${KERNEL_VERSION}" ] && export KERNEL_VERSION="linux-4.20"
[ -z "${CUSTOMISE_KERNEL}" ] && export CUSTOMISE_KERNEL="false"
[ -z "${DEFAULT_FILESYSTEM}" ] && export DEFAULT_FILESYSTEM="Debian-Wheezy-AMD64-root_fs"
[ -z "${DEFAULT_COW_DISK}" ] && export DEFAULT_COW_DISK="cow-01"


# Install the require tools to build the kernel.
function uml::install-tools() {
    # NB: Add 'libc6-dev-i386' to add 32-0biut support for building 32 bit kernels.
    sudo apt install build-essential libncurses-dev bison flex libssl-dev libelf-dev 
}

# Download the specified kernel version source archive.
function uml::get-source() {
    local version="${1-${KERNEL_VERSION}}"
    local url="https://cdn.kernel.org/pub/linux/kernel/v4.x"

    # Move to the target 'build' directory.
    mkdir -p "${UML_BUILD}" && pushd "${UML_BUILD}"

    # If the kernel source archive does not exist; then download it. 
    if [ ! -f "${version}.tar.xz" ]; then
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

    echo "Downloaded, verified, and unpacked kernel '${version}' source to $PWD/${version}"
    
    popd
}

# Clean the target directory.
function uml::delete-source {
    local version="${1-${KERNEL_VERSION}}"
    rm -R "${UML_BUILD}"
}

# Build a UML kernel.
function uml::build {
    local version="${1-${KERNEL_VERSION}}"
    pushd "${UML_BUILD}/${version}"
    # Clean existing config.
    make ARCH=um mrproper
    # Initialise a UML build config.
    make ARCH=um defconfig
    # If specified, customise the kernel. 
    if [ "${CUSTOMISE_KERNEL}" == "true" ]; then
        # 1. `UML-specific options` → `64-bit kernel` → ENABLE
        # 2. `General setup` → `Initial RAM filesystem and RAM disk support` → ENABLE 
        # 3. `Kernel hacking` → `Compile-time checks and compiler options` → `Compile the kernel with debug information`
        make ARCH=um menuconfig
    fi
    # Build the kernel.
    # make -j 4 ARCH=um 
    make ARCH=um 
    # If successfull rename the kernel and move it to the UMD environment.
    if [ ! -f "${linux}" ]; then
        mv linux "${version}-uml"
        mkdir -p "${UML_KERNELS}"
        cp "${version}-uml" "${UML_KERNELS}/${version}-uml"
    fi
    popd
}

# Download all configured file systems.
function uml::get-filesystems() {
    # Move to the target 'filesystem' directory.
    mkdir -p "${UML_FILESYSTEMS}" && pushd "${UML_FILESYSTEMS}"

    local url="http://fs.devloop.org.uk/filesystems"
    local fs01="${DEFAULT_FILESYSTEM}"

    # If the filesystem is not present, then, download and unpack it.
    if [ ! -f "${fs01}" ]; then
        curl -O "${url}/Debian-Wheezy/${fs01}.bz2"
        bunzip2 "${fs01}.bz2"
        rm -f "${fs01}.bz2"
        chmod u+x "${fs01}"
    fi

    popd
}

# Start a UML instance.
function uml::start() {
    # Specify a kernel to use or use the default as specified by KERNEL_VERSION.
    local cow_disk="${1:-${DEFAULT_COW_DISK}}"
    local root_disk="${2:-${UML_FILESYSTEMS}/${DEFAULT_FILESYSTEM}}"
    local uml_kernel="${3:-${UML_KERNELS}/${KERNEL_VERSION}-uml}"

    echo "Starting UML kernel: '${uml_kernel}'"
    echo "    using root disk: '${root_disk}'"
    echo " NB: Default user 'root' user has no password set."
    echo " NB: Type 'halt' to exit"

    # TODO: Check for the kernel and file system. If not present rhen load em.
    # TODO: See if we need to enable ramfs when compiling the kernel.
    # TODO: Play with networking.

    # ./linux ubd0=cow01,Debian-Wheezy-AMD64-root_fs
    # ./linux ubd0=cow02,Debian-Wheezy-AMD64-root_fs
    local cmd="${uml_kernel} ubd0=${cow_disk},${root_disk}" && $cmd
}

# Miscellaneous ===============================================================
#

# Help for 'kernel' script.
function  uml::help() {
    echo
    echo "*** Commands ***"
    echo
    echo "install-tools              : Install the OS kernel build tools (apt only)."
    echo "get-source      <version>  : Get the kernel source (for the specified version)."
    echo "delete-source   <version>  : Delete the kernel source (for the specified version)."
    echo "build           <version>  : Build the kernel source (for the specified version)."
    echo "get-filesystems            : Download root bootable filesystems."
    echo "start <cow> <fs> <version> : Start UML instance."
    echo
    echo "*** ENVIRONMENT ***"
    echo
    echo "UML_HOME                   : The home directory for UML systems, kernels and filesystems."
    echo "UML_BUILD                  : Define the local path of where to download and build the kernel."
    echo "UML_ENVIRONMENTS           : The home subdirectroy for UML environments (COW disks)."
    echo "UML_KERNELS                : The home subdirectory for UML kernels."
    echo "UML_FILESYSTEMS            : The home subdirectory for UML boot disks."
    echo
    echo "KERNEL_VERSION             : Define the kernel version (kernel.org)"
    echo "CUSTOMISE_KERNEL           : If 'true' allow an attending user to configure the kernel before building."
    echo
}

function uml::env() {
    echo
    echo "*** ENVIRONMENT ***"
    echo
    echo "UML_HOME         : ${UML_HOME}"
    echo "UML_BUILD        : ${UML_BUILD}"
    echo "UML_ENVIRONMENTS : ${UML_ENVIRONMENTS}"
    echo "UML_KERNELS      : ${UML_KERNELS}"
    echo "UML_FILESYSTEMS  : ${UML_FILESYSTEMS}"
    echo
    echo "KERNEL_VERSION   : ${KERNEL_VERSION}"
    echo "CUSTOMISE_KERNEL : ${CUSTOMISE_KERNEL}"
    echo
}


# Module ======================================================================
#

function uml::load() {
    [[ "${BASH_SOURCE[0]}" == "${0}" ]] \
        && echo "The 'load' command must be 'sourced' when invoked." && exit 1
    local target="$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)/$(basename ${BASH_SOURCE[0]})"
    alias uml="${target}"
}

function uml::unload() {
    [[ "${BASH_SOURCE[0]}" == "${0}" ]] \
        && echo "The 'unload' command must be 'sourced' when invoked." && exit 1
    unalias uml
    unset -v $(env | grep UML | cut -d'=' -f1 | xargs)
    unset -f $(declare -F | grep 'uml::' | awk '{print $NF}' | xargs)
}

function uml::reload() {
    local module="$(alias | grep 'uml=' | cut -d'=' -f2 | xargs)"
    . "${module}" unload
    . "${module}" load
}

if [ ! -z "$1" ]; then
    uml::$*
fi
