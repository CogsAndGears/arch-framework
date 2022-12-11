######
# Set up sudo
echo "Adding sudo"
groupadd sudo
pacman -S --noconfirm sudo
# Enable sudo group to perform commands
sed -i 's/# %sudo/%sudo/g'  /etc/sudoers

######
## Set up initial user
echo "Creating initial user: ${OS_USERNAME}"
useradd -m "${OS_USERNAME}"
usermod -a -G sudo "${OS_USERNAME}"
usermod --password "${OS_USER_PASSWORD}" "${OS_USERNAME}"

######
# set up bluetooth
# https://wiki.archlinux.org/title/bluetooth
echo "Configuring bluetooth"
pacman -S --noconfirm\
	bluez\
	bluez-utils

systemctl enable bluetooth

######
# set up audio
echo "Configuring audio"
pacman -S --noconfirm\
	alsa-utils\
	pulseaudio

if [ -f "${OS_INSTALL_DIR}/extra.sh" ]; then
	echo "Running user-defined extras.sh script"
	source "${OS_INSTALL_DIR}/extra.sh"
else
	echo "No user script at ${OS_INSTALL_DIR}/extras.sh; skipping"
fi
