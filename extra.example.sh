INSTALL=pacman -S --noconfirm

XFCE_REQ=\
	xorg\
	xfce4\
	xfce4-goodies\
	# needed to manage sound devices
	pavucontrol\
	# application search bar
	synapse

KDE_REQ=\
	plasma-desktop\
	sddm

DESKTOP_REQ=${XFCE_REQ}

EXTRA_UTILITIES=\
	robotfindskitten\
	git\
	konsole\
	firefox\
	emacs\
	vscode\
	discord

ALL_PACKAGES=\
	${DESKTOP_REQ}\
	${BUILD_UTILITIES}\
	${EXTRA_UTILITIES}

# debian-equivalent packages for fully featured python build from source
# Usually would be installed with:
# apt-get build-essential gdb lcov pkg-config \
#     libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
#     libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
#     lzma lzma-dev tk-dev uuid-dev zlib1g-dev
PYTHON_BUILD_UTILITIES=\
	# lcov
	lcov\
	# pkg-config
	pkgconf\
	# libbz2-dev
	bzip2\
	# libffi-dev
	libffi\
	# libgdbm-dev
	# libgdbm-compat-dev
	gdbm\
	# liblzma-dev
	xz\
	# libncurses5-dev <-- must be installed via AUR
	# libreadline6-dev
	readline\
	# libsqlite3-dev
	sqlite\
	# libssl-dev
	openssl\
	# lzma <-- must be installed via AUR
	# lzma-dev
	# tk-dev
	tk\
	# uuid-dev
	util-linux\
	util-linux-libs\
	# zlib1g-dev
	zlib

BUILD_UTILITIES=\
	pkgfile\
	base-devel\
	gdb\
	${PYTHON_BUILD_UTILITIES}

$INSTALL ${ALL_PACKAGES}

# remove if pkgfile is not installed
pkgfile --update

# Add custom X11 configs; includes setting dvorak as the default keyboard
cp ${OS_INSTALL_DIR}/conf/xorg.conf.d/* /etc/X11/xorg.conf.d/.

######
# Configure startx to start xfce4
cp /etc/xdg/xfce4/xinitrc /home/${OS_USERNAME}/.xinitrc

######
# Disable auto-light detection/brightness adjustment in favour of maniual adjustment. Currently
# it seems to be a one or the other situation
cp ${OS_INSTALL_PATH}/conf/modprobe.d/* /etc/modprobe.d/.

######
# Configure AUR
pacman -S base-devel

git clone 
