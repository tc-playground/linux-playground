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

# Partitioning
# Old style using d-i command
#d-i partman-auto/disk string /dev/sda
#d-i partman-auto/method string regular
#d-i partman-lvm/device_remove_lvm boolean true
#d-i partman-md/device_remove_md boolean true
#d-i partman-auto/choose_recipe select atomic

# Newer ubiquity command
ubiquity partman-auto/disk string /dev/sda
ubiquity partman-auto/method string regular
ubiquity partman-lvm/device_remove_lvm boolean true
ubiquity partman-md/device_remove_md boolean true
ubiquity partman-auto/choose_recipe select atomic

# This makes partman automatically partition without confirmation
d-i partman-partitioning/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true

# Locale
d-i debian-installer/locale string en_US
d-i console-setup/ask_detect boolean false
d-i console-setup/layoutcode string us

# Network
d-i netcfg/get_hostname string unassigned-hostname
d-i netcfg/get_domain string unassigned-domain
d-i netcfg/choose_interface select auto

# Clock
d-i clock-setup/utc-auto boolean true
d-i clock-setup/utc boolean true
d-i time/zone string US/Pacific
d-i clock-setup/ntp boolean true

# Packages, Mirrors, Image
d-i mirror/country string US
d-i apt-setup/multiverse boolean true
d-i apt-setup/restricted boolean true
d-i apt-setup/universe boolean true

# Users
d-i passwd/user-fullname string User
d-i passwd/username string user
d-i passwd/user-password-crypted password yourEncryptedPasswd
d-i passwd/user-default-groups string adm audio cdrom dip lpadmin sudo plugdev sambashare video
d-i passwd/root-login boolean true
d-i passwd/root-password-crypted password rootEncryptedPasswd
d-i user-setup/allow-password-weak boolean true

# Grub
d-i grub-installer/grub2_instead_of_grub_legacy boolean true
d-i grub-installer/only_debian boolean true
d-i finish-install/reboot_in_progress note

# Custom Commands
ubiquity ubiquity/success_command string \
  sed -i -e 's/dns=dnsmasq/#dns=dnsmasq/' /target/etc/NetworkManager/NetworkManager.conf ;\
  cp -a /cdrom/scripts/ /target/root/ ;\
  cp -a /cdrom/salt/ /target/root/
EOF
    chmod 444 "${extraction_path}/preseed/custom.seed"
    chmod u-w "${extraction_path}/preseed"

    echo "Generated custom preseed: ${extraction_path}/preseed/custom.seed"
}

# GENERATE Installer Menu
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


# CREATE custom iso image
function preseed::create-custom-iso-image() {
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
    preseed::create-custom-iso-image "${extraction_path}"
    # sudo rm -Rf "${extraction_path}"
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