# Configure Gnome 3

## Introduction

* Install `gnome-tweak-tool`.

* Install `Gnome Shell Extensions`.

---

## 1. Install `gnome-tweak-tool`

    ```bash
    sudo apt-get install gnome-tweak-tool
    ```
---

## 2. Install `Gnome Shell Extesions`

1. Add `GNOME shell native connector` for operating system.

    ```bash
    sudo apt install chrome-gnome-shell
    ```

2. Add the `GNOME shell integration` to browser of choice.

    * [Gnome Shell Extesions - Firefox](https://addons.mozilla.org/en-US/firefox/addon/gnome-shell-integration/)

3. Install the following extensions:

    1. [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/) - Nicer Dock.

    2. [Refresh WiFi Connections](https://extensions.gnome.org/extension/905/refresh-wifi-connections/) - Refresh WiFi connections.

    3. [Hide Top Bar](https://extensions.gnome.org/extension/545/hide-top-bar/) - Hide the Top Bar!

    4. [Suspend Button](https://extensions.gnome.org/extension/826/suspend-button/)

    5. [Cover FLow Alt-Tab](https://extensions.gnome.org/extension/97/coverflow-alt-tab/) - Fancy `Alt-Tab` animation.

    6. [Extension Notifier](https://extensions.gnome.org/extension/1166/extension-update-notifier/)
    
    > NB: Configure extensions `gnome-tweak-tool`.

    > NB: Install Core Extensions: `sudo apt install gnome-shell-extensions`.

---

## 3. Install `Gnome User Theme Extesions`

1. Install `user themes extension`

    * [Shell User Themes](https://extensions.gnome.org/extension/19/user-themes/)

2. Obtain a theme. There are several types:

    1. __Icon__ - Chnages the `icons`.

    2. __Gnome Shell__ - Change the `desktop chrome`.

    3. __GTK3__ - Change the `windows`.

3. There are several ways to install themes:

    1. __Manually__ - Search and download theme from repositories:

        1. [GNOME Look](https://www.gnome-look.org/browse/cat/134/)

            * [Dark Themes](https://www.addictivetips.com/ubuntu-linux-tips/best-dark-themes-for-linux-in-2018/)

        2. Download and extract into `$HOME/.themes` directory.

    2. __PPA__ - Via a provided repository, e.g. POP, Arc, etc

        * `Arc` - come pre-packages for many systems.

            ```
            sudo apt install arc-theme
            ```

3. Configure them in `gnome-tweak-tool`.

4. To create a custom theme, or, reference default `Gnome 3` themes, create a link in the `.themes`.

    * [Vanilla Gnome Shell 2](https://askubuntu.com/questions/1060677/how-to-get-default-vanilla-gnome-shell-theme-in-ubuntu-18-04-after-update)

    * [Vanilla Gnome Shell 2](https://askubuntu.com/questions/969657/how-to-install-the-latest-ubuntu-shell-theme-under-ubuntu-with-vanilla-gnome/969667#969667) directory.


    * e.g. `~/.themes/Temple-Dark/gnome-shell/gnome-shell.css

        ```css
        @import url("/usr/share/gnome-shell/theme/gnome-shell.css");
        ```

---

## 4. Enable Fractional Scaling

* __Gnome 3.32 - Wayland__

    ```bash
    gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
    ```
* __Gnome 3.32 - Xorg__

    ```bash
    gsettings set org.gnome.mutter experimental-features "['x11-randr-fractional-scaling']"
    ```

* __Reset Fractional Scaling__

    ```bash
    gsettings reset org.gnome.mutter experimental-features
    ```

---

## Install `dconf editor` - Manage GNOME Configuration

```bash
sudo apt install dconf-editor
```

---

## References

* [Configure Gnome 3](https://medium.com/@me_59374/getting-started-with-gnome3-a-primer-on-customization-9d53689b7396)

* [Gnome Shell Integration For Chrome](https://wiki.gnome.org/Projects/GnomeShellIntegrationForChrome/Installation)

* [Configure G3 Themes](https://itsfoss.com/install-themes-ubuntu/)

    *[Best Themes](https://itsfoss.com/best-gtk-themes/)

* [Configure G3 Fractional Scaling](http://ubuntuhandbook.org/index.php/2019/10/how-to-enable-fractional-scaling-in-ubuntu-19-10-eoan/)

* [Configure G3 Fractional Scaling](https://www.omgubuntu.co.uk/2019/06/enable-fractional-scaling-ubuntu-19-04)
