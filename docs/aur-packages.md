# Managing AUR Packages
## Installing an AUR Package
First clone the repository, or pull if you are updating an existing package.

Then `cd` into the directory and run `makepkg -scri`. It will build the package and then, at the end, ask for your password to install it. `c` will clean the build artifacts afterwards, `r` will remove any installed dependencies that were needed as part of the build process.

(don't run as root, it will prompt you if necessary)
```bash
makepkg -scri
```

## Uninstalling

Find the package you want to uninstall

```bash
pacman -Qm
```

And remove it
- `-R` : remove
- `-n` : remove configurations (leave no trace)
- `-s` : remove orphaned dependencies
```bash
sudo pacman -Rns <package name>
```

# Some helpful packages
Helpful AUR packages that I'm using:

- [VS Code (Microsoft)](https://aur.archlinux.org/packages/visual-studio-code-bin) [git](https://aur.archlinux.org/visual-studio-code-bin.git)
	- Apparently incompatible with Code
- [BCompare](https://aur.archlinux.org/packages/bcompare) [git](https://aur.archlinux.org/bcompare.git)
- [Figma Linux](https://aur.archlinux.org/packages/figma-linux-bin) [git](https://aur.archlinux.org/figma-linux-bin.git)
	- Has intermittent problems. Might be better to just use the web app
- Nerd Fonts Jetbrains Mono [git](https://aur.archlinux.org/nerd-fonts-jetbrains-mono.git)
	- I'm not positive what happened to the AUR page for this one. Might have moved [here](https://archlinux.org/packages/extra/any/ttf-jetbrains-mono-nerd/)?
	- Either way, just a nice font pack with ligatures
