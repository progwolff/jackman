# jackman
Collection of scripts that help managing multiple audio interfaces with Jack

# Features
 
- Persistent configurations per device
-- jackman keeps your jack configurations for each audio device and configures jack for you.
- Hotplugging
-- Based on priorities jackman will change your jack master device when you plug in a USB audio interface with higher priority than the current master.
-- If you remove a USB device that is the current master, jackman will configure the remaining card with highest priority as new master. No need to restart jack 
manually.
- Works great in combination with libflashsupport-jack and pulseaudio-jack.
-- Just press play, jackman will care for your device configuration

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

# Usage

run `jackman -h` for help
