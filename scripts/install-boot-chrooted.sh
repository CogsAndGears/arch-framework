#!/usr/bin/env bash
# Installation of core components that will be needed to run the system. After this point
# we could actually start the computer and install the rest, if we felt like it

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source ${SCRIPT_DIR}/env.sh

# set root password
usermod --password "${OS_ROOT_PASSWORD}" root

echo "Setting time zone to: ${TIME_ZONE}"
ln -sf ${TIME_ZONE}
echo "Generating /etc/adjtime
hwclock --systohc
echo "Setting locale to: ${OS_LOCALE}"
echo "LANG=${LOCALE}" > /etc/locale.conf
echo "Setting keymap to: ${OS_KEYMAP}"
echo "KEYMAP=${KEYMAP}" > /etc/vconsole.conf
echo "Setting Hostname to: "${OS_HOSTNAME}"
echo "${OS_HOSTNAME}" > /etc/hostname

echo "Installing wireless managers"
pacman -S --noconfirm dhcpcd iwd
systemctl enable iwd
systemctl enable dhcpcd

echo -e "127.0.0.1\tlocalhost\n::1\tlocalhost" >> /etc/hosts
