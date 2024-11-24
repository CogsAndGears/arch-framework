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
```
