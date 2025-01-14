### Using a VPN
[Some handy instructions](https://hogwarts.zone/install-wireguard-client-on-arch-linux/)
Install wireguard tools.

```bash
sudo pacman -Sy wireguard-tools
```

Generate keys if you don't have a config file

```bash
wg genkey | tee privatekey | wg pubkey > publickey
```

Add the configuration file to the wireguard directory (eg. `/etc/wireguard/wg0.config`)

It will look something like this:

In the file `wg0.conf`:
```
[Interface]
PrivateKey = `PRIVATEKEY`
Address = `IPV4FROMVPNPROVIDER`,`IPV6FROMVPNPROVIDER`
DNS = `VPNDNS4`,`VPNDNS6`
PostUp = ip route add `192.168.1.0/24 via 192.168.1.1`;
PreDown = ip route delete `192.168.1.0/24`;

[Peer]
PublicKey = `PUBLICKEY`
AllowedIPs = `0.0.0.0/0`,`::0/0`
Endpoint = `PUBLICVPNSERVERIP`:`PORT`
PersistentKeepalive = 25
```

Then enable the interface:

```bash
sudo systemctl start wg-quick@wg0
```
And stop it when done
```bash
sudo systemctl stop wg-quick@wg0
```
Some more commands
```bash
sudo systemctl status wg-quick@wg0
sudo systemctl enable wg-quick@wg0 # to start it when the computer starts
```

You can name the files however you like, and the part before the `.conf` will be the interface name.