# Some user-specific configuration

######
# Rest of setup

INSTALL="pacman -S --noconfirm"

XFCE_REQ=$(cat <<ENDVAR
	xorg
	xfce4
	xfce4-goodies
	pavucontrol
	synapse
	gvfs
	thunar-volman
ENDVAR
)

# COMMENTS
# pavucontrol - needed to manage sound devices
# synapse - application search bar
# gvfs - file system management
# thunar-volman - removable drive management

KDE_REQ=$(cat <<ENDVAR
	plasma-desktop
	sddm
ENDVAR
)

DESKTOP_REQ=${XFCE_REQ}

EXTRA_UTILITIES=$(cat <<ENDVAR
	robotfindskitten
	git
	konsole
	firefox
	emacs
	vscode
	discord
	curl
	wget
	nfs-utils
	smbclient
	zsh
ENDVAR
)


# debian-equivalent packages for fully featured python build from source
# Usually would be installed with:
# apt-get build-essential gdb lcov pkg-config \
#     libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
#     libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
#     lzma lzma-dev tk-dev uuid-dev zlib1g-dev
PYTHON_BUILD_UTILITIES=$(cat <<ENDVAR
	lcov
	pkgconf
	bzip2
	libffi
	gdbm
	xz
	readline
	sqlite
	openssl
	tk
	util-linux
	util-linux-libs
	zlib
ENDVAR
)

# COMMENTS
# PYTHON = ARCH EQUIVALENT
# lcov = lcov
# pkg-config = pkgconf
# libbz2-dev = bzip2
# libffi-dev = libffi
# libgdbm-dev libgdm-compat-dev = gdbm
# liblzma-dev = xz
# libncurses5-dev = must be installed via AUR
# libreadline6-dev = readline
# libsqlite3-dev = sqlite
# libssl-dev = openssl
# lzma lzma-dev = must be installed via AUR
# tk-dev = tk
# uuid-dev = util-linux util-linux-libs
# zlib1g-dev = zlip

BUILD_UTILITIES=$(cat <<ENDVAR
	pkgfile
	base-devel
	gdb
	cmake
	${PYTHON_BUILD_UTILITIES}
ENDVAR
)

ALL_PACKAGES=$(cat <<ENDVAR
	${DESKTOP_REQ}
	${BUILD_UTILITIES}
	${EXTRA_UTILITIES}
ENDVAR
)

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
cp ${OS_INSTALL_DIR}/conf/modprobe.d/* /etc/modprobe.d/.

######
# Set zsh as default shell
usermod --shell /usr/bin/zsh cogs
