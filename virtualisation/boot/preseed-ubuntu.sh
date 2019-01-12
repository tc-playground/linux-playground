#!/bin/bash

[ -z "${PRESEED_HOME}" ] && export PRESEED_HOME="${HOME}/tmp/preseed"
[ -z "${PRESEED_ISO_PATH}" ] && export PRESEED_ISO_PATH="${PRESEED_HOME}"
[ -z "${PRESEED_VANILLA_ISO}" ] && export PRESEED_VANILLA_ISO="ubuntu-18.10-live-server-amd64.iso"

# Images ----------------------------------------------------------------------
#

# DOWNLOAD some isos to the specified directory.
function preseed::vanilla-iso-download() {
    local target_dir="${1:-${PRESEED_ISO_PATH}}"
    local target="${2:-${PRESEED_VANILLA_ISO}}"

    mkdir -p "${target_dir}"
    pushd "${target_dir}" > /dev/null

    if [ ! -f "${target}" ]; then
        curl -LO "http://releases.ubuntu.com/18.10/${target}"
    else
        echo "ISO '${target}'' already download..."
    fi

    popd > /dev/null 
}

# MOUNT the image to modify.
# e.g. preseed extract-iso-image $HOME/tmp/preseed/ubuntu-18.10-live-server-amd64.iso
function preseed::extract-iso-image() {
    local iso_path=$1
    local extraction_path="${2:-$(dirname ${iso_path})}"
    local mount_path="${3:-/mnt/cdrom}"

    echo "Mounting: ${iso_path} -> ${mount_path}"
    sudo mount -o loop "${iso_path}" "${mount_path}"

    if [ ! -d "${extraction_path}" ]; then
        echo "Extracting: ${mount_path} -> ${extraction_path}"
        mkdir -p "${extraction_path}"
        # rsync -av "${mount_path}" "${extraction_path}/iso"
        cp -rT "${mount_path}" "${extraction_path}"
    fi

    # sudo apt-get install debconf-utils
    # debconf-get-selections >> selections.txt

    echo "Unmounting: ${iso_path} -> ${mount_path}"
    sudo umount "${mount_path}"
}


# GENERATE the preseed file.
function preseed::generate-preseed() {
    local extraction_path=$1

    echo "Generating custom preseed: ${extraction_path}/preseed/custom.seed"

    # Write network configuration.
    chmod u+w "${extraction_path}/preseed"
    touch "${extraction_path}/preseed/custom.seed"
    cat > "${extraction_path}/preseed/custom.seed" << EOF
#### Contents of the peconfiguration file (for cosmic)
# Localization
d-i debian-installer/language string en
d-i debian-installer/country string gb
d-i debian-installer/locale string en_GB.UTF-8

# Keyboard selection.
d-i console-setup/ask_detect boolean false
d-i keyboard-configuration console-setup/detected note
d-i keyboard-configuration/layoutcode string gb
d-i keyboard-configuration/model select Generic 105-key (Intl) PC
d-i keyboard-configuration/xkb-keymap select gb
# d-i keyboard-configuration/xkb-keymap select British English

# Network configuration
d-i netcfg/choose_interface select auto
d-i netcfg/hostname string unnamed
d-i netcfg/wireless_wep string

# Mirror settings (assume no proxy is required)
# d-i mirror/http/proxy string
# d-i mirror/http/mirror select ubuntu.mirrors.uk2.net/ubuntu/

# To create a normal user account.
d-i passwd/user-fullname string Ubuntu User
d-i passwd/username string ubuntu

# default password is ubuntu
d-i passwd/user-password-crypted password ubuntu
d-i user-setup/allow-password-weak boolean true
d-i user-setup/encrypt-home boolean false

# Clock and time zone setup
d-i clock-setup/utc boolean true
d-i time/zone string Europe/London
d-i clock-setup/ntp boolean true
d-i clock-setup/ntp-server string uk.pool.ntp.org

# Partitioning
d-i partman-auto/method string regular
d-i partman-lvm/device_remove_lvm boolean true
d-i partman-md/device_remove_md boolean true
d-i partman-lvm/confirm boolean true
d-i partman-lvm/confirm_nooverwrite boolean true
d-i partman-auto/choose_recipe select atomic
d-i partman/default_filesystem string ext4
d-i partman-partitioning/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true
d-i partman/mount_style select uuid

# Package selection
# below command has no d-i in it, it is not an error
# remove this line alone allow selection of packages
tasksel tasksel/first multiselect ubuntu-server
# the below packages will be installed even if you comment out the above line and choose nothing to install during package selection.
d-i pkgsel/include string openssh-server vim samba
d-i pkgsel/upgrade select none
d-i pkgsel/update-policy select none

# GRUB configuration, disable splash and quiet to reduce error in graphics drivers of virtual machines
d-i debian-installer/quiet boolean false
d-i debian-installer/splash boolean false
d-i grub-installer/only_debian boolean true
d-i grub-installer/timeout string 10

d-i finish-install/reboot_in_progress note
d-i cdrom-detect/eject boolean false

EOF
    chmod 444 "${extraction_path}/preseed/custom.seed"
    chmod u-w "${extraction_path}/preseed"

    echo "Generated custom preseed: ${extraction_path}/preseed/custom.seed"
}


function preseed::generate-installer-menu() {
        local extraction_path=$1

    echo "Generating custom installer menu config: ${extraction_path}/isolinux/txt.cfg"

    # Write network configuration.
    chmod u+w "${extraction_path}/isolinux"
    chmod u+w "${extraction_path}/isolinux/txt.cfg"
    cat > "${extraction_path}/isolinux/txt.cfg" << EOF
label autoinstall
  menu label ^Install Ubuntu Server
  kernel /casper/vmlinuz
  append auto=true file=/cdrom/preseed/custom.seed boot=casper initrd=/casper/initrd nosplash ---
EOF
    chmod 444 "${extraction_path}/isolinux/txt.cfg"
    chmod u-w "${extraction_path}/isolinux"

    echo "Generated installer menu config: ${extraction_path}/isolinux/txt.cfg"
}

function preseed::bake-custom-iso-image() {
    local extraction_path=$1
    local parent_path="$(dirname ${extraction_path})"

    sudo mkisofs -J -l -b isolinux/isolinux.bin \
        -no-emul-boot \
        -boot-load-size 4 \
        -boot-info-table \
        -z \
        -iso-level 4 \
        -c isolinux/boot.cat \
        -o "${parent_path}/ubuntu-18.10-custom-live-server-amd64.iso" \
        -joliet-long \
        "${extraction_path}"
}


# Generate a custom iso.
function preseed::build-custom-iso() {
    local iso_name="${PRESEED_VANILLA_ISO}"
    local build_path="${PRESEED_ISO_PATH}"
    local extraction_path="${build_path}/iso"
    local mount_path="/mnt/cdrom"
    
    preseed::vanilla-iso-download "${build_path}" "${iso_name}"
    preseed::extract-iso-image "${build_path}"/"${iso_name}" "${extraction_path}" "${mount_path}"
    preseed::generate-preseed "${extraction_path}"
    preseed::generate-installer-menu "${extraction_path}"
    preseed::bake-custom-iso-image "${extraction_path}"
}


# Module ======================================================================
#

function preseed::load() {
    [[ "${BASH_SOURCE[0]}" == "${0}" ]] \
        && echo "The 'load' command must be 'sourced' when invoked." && exit 1
    local target="$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)/$(basename ${BASH_SOURCE[0]})"
    alias preseed="${target}"
}

function preseed::unload() {
    [[ "${BASH_SOURCE[0]}" == "${0}" ]] \
        && echo "The 'unload' command must be 'sourced' when invoked." && exit 1
    unalias preseed
    unset -v $(env | grep PRESEED | cut -d'=' -f1 | xargs)
    unset -f $(declare -F | grep 'preseed::' | awk '{print $NF}' | xargs)
}

function preseed::reload() {
    local module="$(alias | grep 'preseed=' | cut -d'=' -f2 | xargs)"
    source "${module}" unload
    source "${module}" load
}

if [ ! -z "$1" ]; then
    preseed::$*
fi