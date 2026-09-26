## Finding a package from a Debian repository in pacman

Sometimes you'll want to find an equivalent package in pacman to one that exists in another package manager, such as debian. For these instances, find the package on debian's site: `https://packages.debian.org/<SEARCH_TERM>` and find the file list for one of the distributions.

Pick a file that seems reasonable, and use `pkgfile -s <FILE_NAME>` to see whether that file can be found in any of the known pacman repositories.

# Notes

# Removing orphans

https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Removing_unused_packages_(orphans)

```bash
pacman -Qdtq | pacman -Rns -
```

This will sometimes correct issues with dependency graph resolution, so just an occasional maintenance item.

## Check why a package was installed

```bash
pacman -Qi ripgrep
```

Which will output something like this:

```
Name            : ripgrep
Version         : 14.1.1-1
Description     : A search tool that combines the usability of ag with the raw speed of grep
Architecture    : x86_64
URL             : https://github.com/BurntSushi/ripgrep
Licenses        : MIT  custom
Groups          : None
Provides        : None
Depends On      : gcc-libs  pcre2
Optional Deps   : None
Required By     : None
Optional For    : None
Conflicts With  : None
Replaces        : None
Installed Size  : 5.03 MiB
Packager        : Sven-Hendrik Haase <svenstaro@archlinux.org>
Build Date      : Mon 09 Sep 2024 03:48:52 PM CDT
Install Date    : Tue 10 Sep 2024 06:18:19 PM CDT
Install Reason  : Installed as a dependency for another package
Install Script  : No
Validated By    : Signature
```

Note that "install reason" it is a dependency, and also that nothing depends on it.

# Fun Easter eggs

Under config, add `ILoveCandy` `/etc/pacman.conf`

```ini
[config]
ILoveCandy
```

Turns the loading bar into Pacman.

https://eeggs.com/items/59538.html

