https://trackerninja.codeberg.page/post/importing-color-profiles-in-arch-based-linux-using-the-xfce-desktop-environment/

If not configured properly the displays might not show up in color profiles in xfce, if that's the case then do the following.

Install `xiccd`

```bash
pacman -Sy xiccd
```

Start or restart the colord service

```bash
sudo systemctl start colord
```

Run xiccd in a separate terminal and keep it running until restarting.

```bash
sudo xiccd
```

In a different terminal, run:

```bash
colormgr get-devices
```

And then:

```bash
colormgr get-profiles
```

At this point the device and profiles should be showing up in color profiles. You can also manage the profiles in the command line as below.

Link your profile to your device:

```bash
colormgr device-add-profile device_id profile_id
```

eg.

```bash
colormgr device-add-profile xrandr-BOE-NE135A1M-NY1 icc-eca2e6d155d550a5e78c97a34ac3fcae
```

And set it as the default

```bash
colormgr device-add-profile device_id profile_id
```

eg.

```bash
colormgr device-make-profile-default xrandr-BOE-NE135A1M-NY1 icc-eca2e6d155d550a5e78c97a34ac3fcae
```

## Add a custom profile

```bash
sudo cp profile-name.icc /usr/share/color/icc/colord/.
sudo systemctl restart colord.service
```

