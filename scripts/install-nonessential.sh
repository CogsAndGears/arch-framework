set -e

######
# Set up sudo
echo "Adding sudo"
if [ -z "$(getent group sudo)" ]; then
	groupadd sudo
fi
pacman -S --noconfirm sudo
# Enable sudo group to perform commands
sed -i 's/# %sudo/%sudo/g'  /etc/sudoers

######
## Set up initial user
echo "Creating initial user: ${OS_USERNAME}"
if [ ! $(id ${OS_USERNAME}) ]; then
	useradd -m "${OS_USERNAME}"
fi
usermod -a -G sudo "${OS_USERNAME}"
usermod --password "${OS_USER_PASSWORD}" "${OS_USERNAME}"

######
# set up audio
echo "Configuring audio"
pacman -S --noconfirm\
	alsa-utils\
	pulseaudio

######
# set up bluetooth
# https://wiki.archlinux.org/title/bluetooth
echo "Configuring bluetooth"
pacman -S --noconfirm\
	bluez\
	bluez-utils\
	pulseaudio-bluetooth

# COMMENTS
# pulseaudio-bluetooth helps with bluetooth headphones


systemctl enable bluetooth

######
# set up hibernation
# add `resume` to hooks right before fsck
sed -i 's!^\(HOOKS=.*\)\( \)\(fsck.*\)!\1 resume \3!' /etc/mkinitcpio.conf
# recompile mkinitcpio
mkinitcpio -p linux


######
# Set up flash drive mounting
pacman -S --noconfirm\
  udisks2

usermod -a -G storage "${OS_USERNAME}"

######
# Run the user-defined "extra.sh" script for personalized extra install items, if it exists
if [ -f "${OS_INSTALL_DIR}/extra.sh" ]; then
	echo "Running user-defined extras.sh script"
	source "${OS_INSTALL_DIR}/extra.sh"
else
	echo "No user script at ${OS_INSTALL_DIR}/extras.sh; skipping"
fi

