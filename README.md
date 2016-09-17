# jackman
Collection of scripts that help managing multiple audio interfaces with Jack

[![Build Status](https://travis-ci.org/progwolff/jackman.svg?branch=master)](https://travis-ci.org/progwolff/jackman)

# Features
 
- Persistent configurations per device
 - jackman keeps your jack configurations for each audio device and configures jack for you.
- Hotplugging
 - Based on priorities jackman will change your jack master device when you plug in a USB audio interface with higher priority than the current master.
 - If you remove a USB device that is the current master, jackman will configure the remaining card with highest priority as new master. No need to restart jack 
manually.
- alsa_in, alsa_out
 - For all other devices, alsa_in and alsa_out interfaces will be created  
- Works great in combination with libflashsupport-jack and pulseaudio-jack.
 - Just press play, jackman will care for your device configuration

# Dependencies
- bash
- systemd
- jack
- alsa-utils
- cpulimit
- kdialog [optional]
- zenity [optional]

# Installation

## Arch Linux 
Use the provided PKGBUILD

## Other Distros

Copy the following files:

|  File                      | Destination                              |
|----------------------------|------------------------------------------|
| `jackman`                  | `/usr/bin/`                              |
| `jackman_udev_plug`        | `/usr/bin/`                              |
| `jackman_udev_unplug`      | `/usr/bin/`                              |
| `alsa_name.pl`             | `/usr/bin/`                              |
| `jackman.rules`            | `/etc/udev/rules.d/`                     |
| `jackman_plug@.service`    | `/etc/systemd/system/`                   |
| `jackman_unplug@.service`  | `/etc/systemd/system/`                   |
| `jackman_init.service`     | `/etc/systemd/system/`                   |
| `50-jackman.rules`         | `/etc/udev/rules.d/`                     |
| `jackman.desktop`          | `/etc/xdg/autostart/`                    |

Run 
```
# udevadm control -R
# systemctl enable jackman_plug@" ".service
```
or reboot your system.

# Configuration
Copy `jackman.conf` to `$HOME/.config/`.

Add devices to this config file and edit the parameters to your needs.

Devices must be given as `<Alsa Short Name>,<Device Number>`, e.g. `HDA Intel MID,3`.

`$ aplay -l` and `$ jack_control dpd <parameter>` might help to find the right values.

On KDE you might want to use the systemsettings module [jackman_kcm](https://github.com/progwolff/jackman_kcm). 

# Usage

Run `jackman -h` for help or just plug in a USB audio interface.

## Notes on pulseaudio

Install pulseaudio-jack.

This config is recommended (put it to /etc/pulse/daemon.conf):

```
daemonize = yes
fail = yes
high-priority = yes
nice-level = -11
realtime-scheduling = yes
realtime-priority = 5
allow-module-loading = yes
allow-exit = yes
use-pid-file = yes
system-instance = no
local-server-type = user
cpu-limit = no
enable-shm = yes
flat-volumes = no
lock-memory = no
exit-idle-time = 20
scache-idle-time = 20
dl-search-path = /usr/lib/pulse-9.0/modules
default-script-file = /etc/pulse/default.pa
load-default-script-file = yes
log-target = 
log-level = notice
resample-method = speex-float-1
enable-remixing = yes
enable-lfe-remixing = yes
lfe-crossover-freq = 120
default-sample-format = s16le
default-sample-rate = 48000
alternate-sample-rate = 48000
default-sample-channels = 2
default-channel-map = front-left,front-right
default-fragments = 4
default-fragment-size-msec = 25
enable-deferred-volume = yes
deferred-volume-safety-margin-usec = 8000
deferred-volume-extra-delay-usec = 0
shm-size-bytes = 0
log-meta = no
log-time = no
log-backtrace = 0
rlimit-fsize = -1
rlimit-data = -1
rlimit-stack = -1
rlimit-core = -1
rlimit-rss = -1
rlimit-as = -1
rlimit-nproc = -1
rlimit-nofile = 256
rlimit-memlock = -1
rlimit-locks = -1
rlimit-sigpending = -1
rlimit-msgqueue = -1
rlimit-nice = 31
rlimit-rtprio = 9
rlimit-rttime = 200000
```

You may also want to comment out lines 38-58 in /etc/pulse/default.pa to make sure pulse does not grab devices by itself.
