## Finding a package from a Debian repository in pacman

Sometimes you'll want to find an equivalent package in pacman to one that exists in another package manager, such as debian. For these instances, find the package on debian's site: `https://packages.debian.org/<SEARCH_TERM>` and find the file list for one of the distributions.

Pick a file that seems reasonable, and use `pkgfile -s <FILE_NAME>` to see whether that file can be found in any of the known pacman repositories.

