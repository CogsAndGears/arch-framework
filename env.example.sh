###############################
# SET VALUES
# This sectiont is made up of values that must be set by the user and have no known default

# set to whatever you want the initial user username to be. This user will be added
# to sudoers.
export OS_USERNAME=
# These should be pre-hashed passwords; generate via:
# $ openssl passwd -1 <PASSWORD>
export OS_ROOT_PASSWORD=
export OS_USER_PASSWORD=

###############################
# ACTION VALUES
# This section are values that define what actions this script will take, when run.
# In the interest of not having any interactive prompts, all decisions for what will happen
# when this script is run are made at the beginning here. By default, all are disabled so
# that running the script does nothing. Enable based on what you need. For a complete system
# wipe, enable all. Disable any that you are going to perform manually.

# Create new partitions on the hard drive, destroying old ones
export DO_PARTITION=N
# Format the three expected partitions on the hard drive.
export DO_FORMAT=N
# Mount the three expected partitions on the hard drive. Disable if you have a different
# partition schema
export DO_MOUNT=N
# Bootstrap arch, generate fstab
export DO_OS_INSTALL=N
# Set root password, install wireless internet utilities
export DO_ESSENTIAL_INSTALL=N
# Create sudo, add initial user, run anything in `nonessential_install.sh`
export DO_NONESSENTIAL_INSTALL=N
# Unmount the drive after complete
export DO_UNMOUNT=N

###############################
# UNKNOWN VALUES
# This section are values that I don't think should change on my system, but might cause
# problems

# Name of the disk being formatted. It will be one of the items in `dev`, you can
# ask `fdisk -l` to find more information about each known drive, then put in the
# name here. This script will create three partitions
export OS_HD_NAME=nvme0n1
# Automatic dev partition locations; shouln't have to change, but maybe double check
export OS_UEFI_PART="/dev/${OS_HD_NAME}p1"
export OS_SWAP_PART="/dev/${OS_HD_NAME}p2"
export OS_ROOT_PART="/dev/${OS_HD_NAME}p3"
# This will by default create three partitions: EFI, swap, and root. These are the
# ranges for each. The partitions are created in this order
export OS_UEFI_PARTITION_RANGE=1MiB 513MiB
export OS_SWAP_PARTITION_RANGE=514MiB 38GiB
export OS_ROOT_PARTITION_RANGE=39GiB 100%

###############################
# KNOWN VALUES
# This section are values that are set to my personal preference; change if you have
# different preferences

export OS_TIME_ZONE=America/Phoenix
export OS_LOCALE="en_US.UTF-8"
export OS_KEYMAP="dvorak"

export OS_INSTALL_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

