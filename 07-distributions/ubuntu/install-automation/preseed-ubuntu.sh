#!/bin/bash

# Reference: https://github.com/netson/ubuntu-unattended

[ -z "${PRESEED_HOME}" ] && export PRESEED_HOME="${HOME}/tmp/preseed"
[ -z "${PRESEED_ISO_PATH}" ] && export PRESEED_ISO_PATH="${PRESEED_HOME}"
[ -z "${PRESEED_VANILLA_ISO}" ] && export PRESEED_VANILLA_ISO="ubuntu-18.04.1-live-server-amd64.iso"

# Images ----------------------------------------------------------------------
#

# DOWNLOAD some isos to the specified directory.
function preseed::vanilla-iso-download() {
    local target_dir="${1:-${PRESEED_ISO_PATH}}"

    mkdir -p "${target_dir}"
    pushd "${target_dir}" > /dev/null

    if [ ! -f "${PRESEED_VANILLA_ISO}" ]; then
        curl -LO "http://releases.ubuntu.com/18.04.1/${PRESEED_VANILLA_ISO}"
        # curl -LO http://releases.ubuntu.com/18.04.1/ubuntu-18.04.1-live-server-amd64.iso
    else
        echo "ISO '${PRESEED_VANILLA_ISO}'' already downloaded..."
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
    local username=$2
    local password=$3
    local pwhash=$(echo $password | mkpasswd -s -m sha-512)
    local hostname=$4
    local timezone=$5

    echo "Generating custom preseed: ${extraction_path}/preseed/custom.seed"

    # Write network configuration.
    chmod u+w "${extraction_path}/preseed"
    touch "${extraction_path}/preseed/custom.seed"
    cat > "${extraction_path}/preseed/custom.seed" << EOF

# regional setting
d-i debian-installer/language                               string      en_GB:en
d-i debian-installer/country                                string      US
d-i debian-installer/locale                                 string      en_GB
d-i debian-installer/splash                                 boolean     false
d-i localechooser/supported-locales                         multiselect en_GB.UTF-8
d-i pkgsel/install-language-support                         boolean     true

# keyboard selection
d-i console-setup/ask_detect                                boolean     false
d-i keyboard-configuration/modelcode                        string      pc105
d-i keyboard-configuration/layoutcode                       string      gb
d-i keyboard-configuration/variantcode                      string      intl
d-i keyboard-configuration/xkb-keymap                       select      gb(intl)
d-i debconf/language                                        string      en_GB:en

# network settings
d-i netcfg/choose_interface                                 select      auto
d-i netcfg/dhcp_timeout                                     string      5
d-i netcfg/get_hostname                                     string      {{hostname}}
d-i netcfg/get_domain                                       string      {{hostname}}

# mirror settings
d-i mirror/country                                          string      manual
d-i mirror/http/hostname                                    string      archive.ubuntu.com
d-i mirror/http/directory                                   string      /ubuntu
d-i mirror/http/proxy                                       string

# clock and timezone settings
d-i time/zone                                               string      {{timezone}}
d-i clock-setup/utc                                         boolean     false
d-i clock-setup/ntp                                         boolean     true

# user account setup
d-i passwd/root-login                                       boolean     false
d-i passwd/make-user                                        boolean     true
d-i passwd/user-fullname                                    string      {{username}}
d-i passwd/username                                         string      {{username}}
d-i passwd/user-password-crypted                            password    {{pwhash}}
d-i passwd/user-uid                                         string
d-i user-setup/allow-password-weak                          boolean     false
d-i passwd/user-default-groups                              string      adm cdrom dialout lpadmin plugdev sambashare
d-i user-setup/encrypt-home                                 boolean     false

# configure apt
d-i apt-setup/restricted                                    boolean     true
d-i apt-setup/universe                                      boolean     true
d-i apt-setup/backports                                     boolean     true
d-i apt-setup/services-select                               multiselect security
d-i apt-setup/security_host                                 string      security.ubuntu.com
d-i apt-setup/security_path                                 string      /ubuntu
tasksel tasksel/first                                       multiselect Basic Ubuntu server
d-i pkgsel/upgrade                                          select      safe-upgrade
d-i pkgsel/update-policy                                    select      none
d-i pkgsel/updatedb                                         boolean     true

# disk partitioning
d-i partman/confirm_write_new_label                         boolean     true
d-i partman/choose_partition                                select      finish
d-i partman/confirm_nooverwrite                             boolean     true
d-i partman/confirm                                         boolean     true
d-i partman-auto/purge_lvm_from_device                      boolean     true
d-i partman-lvm/device_remove_lvm                           boolean     true
d-i partman-lvm/confirm                                     boolean     true
d-i partman-lvm/confirm_nooverwrite                         boolean     true
d-i partman-auto-lvm/no_boot                                boolean     true
d-i partman-md/device_remove_md                             boolean     true
d-i partman-md/confirm                                      boolean     true
d-i partman-md/confirm_nooverwrite                          boolean     true
d-i partman-auto/method                                     string      lvm
d-i partman-auto-lvm/guided_size                            string      max
d-i partman-partitioning/confirm_write_new_label            boolean     true

# grub boot loader
d-i grub-installer/only_debian                              boolean     true
d-i grub-installer/with_other_os                            boolean     true

# finish installation
d-i finish-install/reboot_in_progress                       note
d-i finish-install/keep-consoles                            boolean     false
d-i cdrom-detect/eject                                      boolean     true
d-i debian-installer/exit/halt                              boolean     false
d-i debian-installer/exit/poweroff                          boolean     false
EOF

    # Update seed file.
    sed -i "s@{{username}}@$username@g" "${extraction_path}/preseed/custom.seed"
    sed -i "s@{{pwhash}}@$pwhash@g" "${extraction_path}/preseed/custom.seed"
    sed -i "s@{{hostname}}@$hostname@g" "${extraction_path}/preseed/custom.seed"
    sed -i "s@{{timezone}}@$timezone@g" "${extraction_path}/preseed/custom.seed"

    # Reset permissions.
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
  menu label ^Autoinstall Ubuntu Server
  kernel /install/vmlinuz
  append file=/cdrom/preseed/ubuntu-server.seed initrd=/install/initrd.gz auto=true priority=high preseed/file=/cdrom/preseed/custom.seed
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
        -o "${parent_path}/ubuntu-18.04.1-custom-live-server-amd64.iso" \
        -joliet-long \
        "${extraction_path}"
}


# Generate a custom iso.
# preseed build-custom-iso temple XXX machine-01 Europe/London
function preseed::build-custom-iso() {

    local username=$1
    local password=$2
    local hostname=$3
    local timezone=$4

    local iso_name="${PRESEED_VANILLA_ISO}"
    local build_path="${PRESEED_ISO_PATH}"
    local extraction_path="${build_path}/iso"
    local mount_path="/mnt/cdrom"
    
    preseed::vanilla-iso-download "${build_path}" "${iso_name}"
    preseed::extract-iso-image "${build_path}"/"${iso_name}" "${extraction_path}" "${mount_path}"
    preseed::generate-preseed "$extraction_path" "$username" "$password" "$hostnamee" "$timezone" 
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