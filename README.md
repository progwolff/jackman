# jackman
Collection of scripts that help managing multiple audio interfaces with [Jack](https://github.com/jackaudio).

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

# Dependencies
- bash
- systemd
- jackdbus
- python2
- alsa-utils
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
# systemctl start jackman_plug@" ".service
```

# Configuration

## Initial Jack configuration

If you already have Jack working with pulseaudio, flash and real time priorities, skip this section.

The following steps will get you a sound system with the following structure:

Pulseaudio -> Jack -> ALSA 

Flash -> Jack -> ALSA

System sounds, media players and generic applications will send audio to pulseaudio, the default sound server in KDE and in many linux distributions.

Pulseaudio will then process this audio data through its engine, apply some mixing (this is the mixer you will likely see in your task panel) and send the final sum to Jack.

Applications that use Jack directly, like DAWs or plugin hosts, will connect to Jack directly, omitting pulseaudio. Note that these applications are not using the mixer in your task panel, they are always at full volume.

Jack finally uses the ALSA driver of your audio interface to send audio data to the audio interfaces' output.

If this setup is for you, continue with the following steps.

Install pulseaudio-jack and libflashsupport-jack

e.g. on Arch Linux:
```
$ packer -S pulseaudio-jack libflashsupport-jack
```

Edit `/etc/pulse/default.pa`. 

Comment out everything under the sections `### Load audio drivers statically` and `### Automatically load driver modules depending on the hardware available` to make sure pulseaudio does not grab any device directly.

Uncomment everything under the section `### Automatically connect sink and source if JACK server is present` to let pulseaudio connect to the Jack server automatically.

In `/etc/pulse/client.conf` set  `autospawn = yes`.

In `/etc/pulse/daemon.conf` set `daemonize = yes`, `realtime-scheduling = yes`, `realtime-priority = 5` and `flat-volumes = no`

Make sure there are no config files in `~/.config/pulse/`.

Assign yourself to the audio group
```
# usermod -a -G audio wolff
```

Install `pam` if you do not have it yet.

Add a file `/etc/security/limits.d/99-audio.conf` with content:
```
@audio  - rtprio        99
@audio  - memlock       unlimited
```
This enables users in the audio group to assign real time priorities to processes

Add the following line to `/etc/pam.d/su`
```
session         required        pam_limits.so
```
This enables users in the audio group to assign real time priorities in a `su` session (needed for hotplugging devices)

Configure Jack to use real time priorities, ALSA and asynchronous mode
```
$ jack_control eps driver alsa
$ jack_control eps realtime True
$ jack_control eps realtime-priority 79
$ jack_control eps sync False
$ jack_control eps clock-source 2
```

Run `$ alsamixer`. For all your cards set all outputs to 0dB (or to the maximum volume you want for this card). Note that volumes above 0dB will lead to distortions.

Run `# alsactl store` to make the changes persistent.

for details on setting up a low latency audio environment see:
* [LinuxMusicians Audio Configuration Checklist](https://linuxmusicians.com/viewtopic.php?f=27&t=15378)
* [LinuxAudio System Configuration](http://wiki.linuxaudio.org/wiki/system_configuration)

## Configuration of jackman

Copy `jackman.conf` to `$HOME/.config/`.

Add devices to this config file and edit the parameters to your needs.

Devices must be given as `<Alsa Short Name>,<Device Number>`, e.g. `HDA Intel MID,3`.

`$ aplay -l` and `$ jack_control dpd <parameter>` might help to find the right values.

On KDE you might want to use the systemsettings module [jackman_kcm](https://github.com/progwolff/jackman_kcm). 

# Usage

Run `jackman -h` for help or just plug in a USB audio interface.

