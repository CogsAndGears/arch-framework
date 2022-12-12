#!/usr/bin/env bash

# Prior to running this script, make a copy of the `./env.example.sh` to
# `./env.sh`, changing any necessary values. This script makes every effort
# to be as hands-off as possible, so any questions will be asked up-front, and
# then you should be able to walk away and have a cup of coffee while the system
# installs.
#
# Also ensure that the computer is connected to the internet prior to starting the
# install, but that should already be true if you were able to download this file
# to run it.

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# Grab configuration variables
source ${SCRIPT_DIR}/env.sh

# Inform about what we're about to do
echo -n "Partition:    "
if [ "${DO_PARTITION}" == "Y" ]; then echo "YES"; else echo "NO"; fi
echo -n "Format:       "
if [ "${DO_FORMAT}" == "Y" ]; then echo "YES"; else echo "NO"; fi
echo -n "EFI Entryy:   "
if [ "${DO_EFI_ENTRY}" == "Y" ]; then echo "YES"; else echo "NO"; fi
echo -n "Mount:        "
if [ "${DO_MOUNT}" == "Y" ]; then echo "YES"; else echo "NO"; fi
echo -n "OS Install:   "
if [ "${DO_OS_INSTALL}" == "Y" ]; then echo "YES"; else echo "NO"; fi
echo -n "Essential:    "
if [ "${DO_ESSENTIAL_INSTALL}" == "Y" ]; then echo "YES"; else echo "NO"; fi
echo -n "Nonessential: "
if [ "${DO_FORMAT}" == "Y" ]; then echo "YES"; else echo "NO"; fi
if [ "${DO_UNMOUNT}" == "Y" ]; then echo "YES"; else echo "NO"; fi

echo -n "Proceed? (y/n) "
read CONTINUE_INSTALL

if [ "${CONTINUE_INSTALL}" != "y" -a "${CONTINUE_INSTALL}" != "Y" ]; then
	echo "Aborting install"
	exit 0
fi

echo "Continuing install"

if [ "${DO_PARTITION}" == "Y" ]; then
	echo "--- PARTITION HD"
	echo "Partitioning ${OS_HD_NAME}"
	parted "/dev/${OS_HD_NAME}" - mkpart "EFI System Partition" fat32 ${OS_UEFI_PARTITION_RANGE}
	parted "/dev/${OS_HD_NAME}" - set 1 esp on
	parted "/dev/${OS_HD_NAME}" - mkpart "Swap Partition" linux-swap ${OS_SWAP_PARTITION_RANGE}
	parted "/dev/${OS_HD_NAME}" - mkpart "Root Partition" ext4 ${OS_ROOT_PARTITION_RANGE}
else
	echo "XXX PARTITION HD (skip)"
fi

if [ "${DO_FORMAT}" == "Y" ]; then
	echo "--- FORMAT PARTITIONS"
	mkfs.fat -F 32 "${OS_UEFI_PART}"
	mkswap "${OS_SWAP_PART}"
	mkfs.ext4 "${OS_ROOT_PART}"
else
	echo "XXX FORMAT PARTITIONS (skip)"
fi

if [ "${DO_EFI_ENTRY}" == "Y" ]; then
	echo "--- EFI ENTRY"
	efibootmgr --create --disk "/dev/${OS_HD_NAME}" --part 1 --label "Arch Linux" --loader /vmlinux-linux --unicode "root=${OS_ROOT_PART} resume=${OS_SWAP_PART} rw initrd=\initramfs-linux.img"
else
	echo "XXX EFI ENTRY (skip)"
fi

if [ "${DO_MOUNT}" == "Y" ]; then
	echo "--- MOUNT PARTITIONS"
	mount "${OS_ROOT_PART}" /mnt
	mount --mkdir "${OS_UEFI_PART}" /mnt/boot
	swapon "${OS_SWAP_PART}"
else
	echo "XXX MOUNT PARTITIONS (skip)"
fi

if [ "${DO_OS_INSTALL}" == "Y" ]; then
	echo "--- OS INSTALL"
	# Bootstrap OS
	pacstrap -K /mnt base linux linux-firmware vi vim man-db man-pages
	echo "Generating fstab"
	genfstab -U /mnt >> /mnt/etc/fstab
	echo "Copying these scripts into /root/arch-framework of new OS"
	cp -r ${SCRIPT_DIR} /mnt/root/arch-framework
else
	echo "XXX OS INSTALL (skip)"
fi

if [ "${DO_ESSENTIAL_INSTALL}" == "Y" ]; then
	echo "--- ESSENTIAL INSTALL"
	arch-chroot /mnt /root/arch-framework/scripts/install-boot-chrooted.sh
else
	echo "XXX ESSENTIAL INSTALL (skip)"
fi

if [ "${DO_NONESSENTIAL_INSTALL}" == "Y" ]; then
	echo "--- NONESSENTIAL INSTALL"
	arch-chroot /mnt /root/arch-framework/install-nonessential.sh
else
	echo "XXX NONESSENTIAL INSTALL (skip)"
fi
