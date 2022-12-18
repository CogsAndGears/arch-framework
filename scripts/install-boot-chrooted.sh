#!/usr/bin/env bash
# Installation of core components that will be needed to run the system. After this point
# we could actually start the computer and install the rest, if we felt like it

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source ${SCRIPT_DIR}/../env.sh

# set root password
usermod --password "${OS_ROOT_PASSWORD}" root

echo "Setting time zone to: ${OS_TIME_ZONE}"
ln -sf "/usr/share/zoneinfo/${OS_TIME_ZONE}" /etc/localtime
echo "Generating /etc/adjtime"
hwclock --systohc
echo "Setting locale to: ${OS_LOCALE}"
echo "LANG=${OS_LOCALE}" > /etc/locale.conf
echo "Setting keymap to: ${OS_KEYMAP}"
echo "KEYMAP=${OS_KEYMAP}" > /etc/vconsole.conf
echo "Setting Hostname to: ${OS_HOSTNAME}"
echo "${OS_HOSTNAME}" > /etc/hostname

# regenerate pacman keys now that we have the timezone set
rm -rf /etc/pacman.d/gnupg
pacman-key --init
pacman-key --populate

echo "Installing wireless managers"
pacman -S --noconfirm dhcpcd iwd
systemctl enable iwd
systemctl enable dhcpcd

echo -e "127.0.0.1\tlocalhost\n::1\tlocalhost" >> /etc/hosts
