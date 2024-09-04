# Arch-Framework

This repository holds utility scripts, instructions, and commands for setting up Arch linux on the framework 12th gen i5 laptop.

For the most part this is so that it is easier for me to nuke my Arch install and bring it back later, as whim dictates.

# Automated instructions

1. Get Arch install media. This can be found [here](https://wiki.archlinux.org/title/installation_guide).
2. Load arch install media onto a flash drive using something like [Rufus](https://rufus.ie/en/) if you are on Windows.
3. Boot into arch
4. Connect to the internet (below)
5. Download this repository. `curl -L https://github.com/CogsAndGears/arch-framework/tarball/main | tar zx`
6. Copy and edit the `env.example.sh` script to `env.sh` and adjust values, as necessary
7. Copy and edit the `extra.example.sh` script to `extra.sh` and modify any additional installation steps or packages, as necessary
6. Run `./install.sh`

# Extra info

## Connecting to a wifi router from command line

To see all the network interfaces, run `ip link`, and to connect to a router use `iwctl`
```
# iwctl
[iwd]# device list
[iwd]# station wlan0 scan
[iwd]# station wlan0 get-networks
[iwd]# station wlan0 connect <SSID>
[iwd]# exit
``` 

## Connecting to a bluetooth device from command line

```
$ bluetoothctl
[bluetooth] power on
[bluetooth] scan on
[bluetooth] devices
[bluetooth] pair <UUID>
[bluetooth] trust <UUID>
[bluetooth] connect <UUID>
```

## Finding a package from a Debian repository in pacman

Sometimes you'll want to find an equivalent package in pacman to one that exists in another package manager, such as debian. For these instances, find the package on debian's site: `https://packages.debian.org/<SEARCH_TERM>` and find the file list for one of the distributions.

Pick a file that seems reasonable, and use `pkgfile -s <FILE_NAME>` to see whether that file can be found in any of the known pacman repositories.

## Installing from AUR
First clone the repository, or pull if you are updating an existing package.

Then `cd` into the directory and run `makepkg -scri`. It will build the package and then, at the end, ask for your password to install it. `c` will clean the build artifacts afterwards, `r` will remove any installed dependencies that were needed as part of the build process.