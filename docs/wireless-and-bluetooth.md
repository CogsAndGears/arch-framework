# Managing wireless connections
## Connecting to a wifi router from command line

To see all the network interfaces, run `ip link`, and to connect to a router use `iwctl`
```
# iwctl
[iwd]# device list
[iwd]# station wlan0 scan
[iwd]# station wlan0 get-networks
[iwd]# station wlan0 connect SSID
[iwd]# exit
```

## Connecting to a bluetooth device from command line

```
$ bluetoothctl
[bluetooth] power on
[bluetooth] scan on
[bluetooth] devices
[bluetooth] pair UUID
[bluetooth] trust UUID
[bluetooth] connect UUID
[bluetooth] remove UUID
```

# Troubleshooting

## Temporary failure in name resolution

Sometimes when coming back up from sleep the network card takes a while to re-initialize, or just refuses to come back up at all. I'm still not really sure why. Typically forcing a network re-scan coerces it into coming back.

```bash
sudo iwctl station wlan0 scan && sudo iwctl station wlan0 get-networks
```
