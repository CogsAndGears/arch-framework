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
