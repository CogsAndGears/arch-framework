Installing Android Studio
-------------------------

Android Studio is probably best installed manually from Google. Download the latest install from their site, untar it in the app directory (for me this is `/srv/app/install/android-studio`) and follow their install instructions. There are then a few steps necessary to utilize command line utilities like `adb` with a real hardware device.

1. Create an alias or add the directory with `adb` to the `PATH`. As of writing `adb` lives in `~/Android/Sdk/platform-tools/adb`.
2. Add your user to the `plugdev` group (create the group if it does not exist)
```
sudo groupadd plugdev
sudo usermod -aG plugdev <username>
```
3. Install the `android-udev` packages
```
pacman -Sy android-udev
```
4. Connect your device and check that it is visible and lists as either "`device`", meaning it is good to go, or "`unauthorized`", meaning you must approve your computer from the device, itself.
```
adb devices
```
