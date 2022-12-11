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
