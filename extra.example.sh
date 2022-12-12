INSTALL=pacman -S --noconfirm

XFCE_REQ=\
	xorg\
	xfce4\
	xfce4-goodies\
	pavucontrol

KDE_REQ=\
	plasma-desktop\
	sddm

DESKTOP_REQ=${XFCE_REQ}

EXTRA_UTILITIES=\
	konsole\
	firefox\
	emacs\
	robotfindskitten

$INSTALL ${DESKTOP_REQ} ${EXTRA_UTILITIES}

# Make Dvorak the X11 default keyboard input
cp ${OS_INSTALL_DIR}/conf/xorg.conf.d/* /etc/X11/xorg.conf.d/.

######
# Configure startx to start xfce4
cp /etc/xdg/xfce4/xinitrc /home/${OS_USERNAME}/.xinitrc

####
# Disable auto-light detection/brightness adjustment in favour of maniual adjustment. Currently
# it seems to be a one or the other situation
cp ${OS_INSTALL_PATH}/conf/modprobe.d/* /etc/modprobe.d/.
