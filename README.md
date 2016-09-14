# jackman
Collection of scripts that help managing multiple audio interfaces with Jack

# Dependencies
- bash
- systemd
- jack
- alsa-utils
- kdialog [optional]
- zenity [optional]

# Installation

## Arch Linux 
use the provided PKGBUILD

## Other Distros

copy the following files:

|  File                      | Destination                              |
|----------------------------|------------------------------------------|
| `jackman`                  | `/usr/bin/`                              |
| `jackman_udev_plug`        | `/usr/bin/`                              |
| `jackman_udev_unplug`      | `/usr/bin/`                              |
| `alsa_name.pl`             | `/usr/bin/`                              |
| `jackman.rules`            | `/etc/udev/rules.d/`                     |
| `jackman_plug@.service`    | `/etc/systemd/system/`                   |
| `jackman_unplug@.service`  | `/etc/systemd/system/`                   |

run 
`# udevadm control -R`
or reboot your system

# Configuration
copy `jackman.conf` to `$HOME/.config/`
add devices to this config file and edit the parameters to your needs

`$ jack_control dpd <parameter>` might help

on KDE you might want to use [jackman_kcm](https://github.com/progwolff/jackman_kcm) 
