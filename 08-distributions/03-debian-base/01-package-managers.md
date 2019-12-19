# Package Management

## Introduction

1. `.deb` is the basic unit of packaging in Debian based systems.

2. There are several ways to manage packages on a Debian based system.

    1. `dpkg` - The core package management program. Can install `.deb` archives directly.

    2. `Advanced Package Tool (APT)` - The primary tool for managing Debian based systems.

        > __Legacy__ commands also exist with slightly different names: `apt-get`, `apt-cache`, etc.

    3. `aptitude` - Provides am `ncurses` frontend to the apt package management infrastructure.

    4. `synaptic` - Provides am `graphical` frontend to the apt package management infrastructure.

    5. __Application Stores__ - Curated content provided by various windows environments and distributions: 

        1. GNOME Software. 
        
        2. Ubuntu Store, 
        
        3. Etc.

    7. __Application Packagers__ - Tools distributing and updating self-contained applications:

        1. [Snap](https://snapcraft.io) - Canonical application manager.

        2. [Flatpak](https://en.wikipedia.org/wiki/Flatpak)

        3. [AppImage](https://en.wikipedia.org/wiki/AppImage)

        4. Etc.

---

## `apt` Commands

### __APT Repositories__

1. [APT Repositories](https://wiki.debian.org/DebianRepository) provide (remote) access to a set of `packages`: 

    1. It is also possible to setup custom [repositories](https://wiki.debian.org/DebianRepository/Setup).

2. [APT Secure Repositories](https://wiki.debian.org/DebianRepository) provide __secure__ (remote) access to a set of `packages`:

    * `apt-key` and `gpg` can be used to ascertain the __integrity__ of `packages` in a secure `repository`.

3. [APT Sources](https://wiki.debian.org/SourcesList) can be configured to install `packages` from a specific `repositories`:

    * `/etc/apt/sources.list` can be configured to `repositories` and obtain `source` and `debug` packages.
    
### __Search Packages__

1. Currently _installed_ packages

    ```bash
    apt list [${packages-glob}]
    ```

2. Search currently _uninstalled_ packages

    ```bash
    apt search [${packages-glob}]
    ```

### __Install Packages__

1. Install package or repository metadata from _local .deb file_:

    ```bash
    apt install ${path-to-deb-file}
    ```
    
2. Install package from _remote repository_:

    ```bash
    apt install [${packages}]
    ```

### __Uninstall Packages__

1. Uninstall just the `${package}`:

    ```bash
    sudo apt-get remove ${package}
    ```

2. Uninstall `${package}` and any dependencies:

    ```bash
    sudo apt-get remove --auto-remove ${package}
    ```

3. Uninstall the `${package}`, any dependencies, and, all `config`:

    ```
    sudo apt purge --auto-remove mlterm  
    ```

---

## References

* [dpkg](https://www.debian.org/doc/manuals/debian-faq/ch-pkgtools.en.html)
 