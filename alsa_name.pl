#!/usr/bin/perl
# fixed and persistent naming for multiple (identical or not) usb soundcards, 
# based on which port-hub-usbbus they connect to
#
# gmaruzz (at) celliax.org 
#
# This is to be executed by udev with the following rules:
#KERNEL=="controlC[0-9]*", DRIVERS=="usb", PROGRAM="/usr/bin/alsa_name.pl %k", NAME="snd/%c{1}"
#KERNEL=="hwC[D0-9]*", DRIVERS=="usb", PROGRAM="/usr/bin/alsa_name.pl %k", NAME="snd/%c{1}"
#KERNEL=="midiC[D0-9]*", DRIVERS=="usb", PROGRAM="/usr/bin/alsa_name.pl %k", NAME="snd/%c{1}"
#KERNEL=="pcmC[D0-9cp]*", DRIVERS=="usb", PROGRAM="/usr/bin/alsa_name.pl %k", NAME="snd/%c{1}"
#
use strict;
use warnings;
#
my $alsaname = $ARGV[0]; #udev called us with this argument (%k)
my $physdevpath = $ENV{PHYSDEVPATH}; #udev put this in our environment
my $alsanum = "cucu";
#you can find the physdevpath of a device with "udevinfo -a -p $(udevinfo -q path -n /dev/snd/pcmC0D0c)"
#
#
$physdevpath =~ s/.*\/([^\/]*)/$1/; #eliminate until last slash (/)
$physdevpath =~ s/([^:]*):.*/$1/; #eliminate from colon (:) to end_of_line
#
if($physdevpath eq "1-5.2") # you can find this value with "dmesg"
{
       $alsanum="11"; #start from "10" (easier for debugging), "0" is for motherboard soundcard, max is "31"
}
if($physdevpath eq "1-5.3") # you can find this value with "dmesg"
{
       $alsanum="12"; #start from "10" (easier for debugging), "0" is for motherboard soundcard, max is "31"
}
if($physdevpath eq "1-5.4") # you can find this value with "dmesg"
{
       $alsanum="13"; #start from "10" (easier for debugging), "0" is for motherboard soundcard, max is "31"
}
if($physdevpath eq "3-2") # you can find this value with "dmesg"
{
       $alsanum="14"; #start from "10" (easier for debugging), "0" is for motherboard soundcard, max is "31"
}
# other bus positions....
#
if($alsanum ne "cucu")
{
       $alsaname=~ s/(.*)C([0-9]+)(.*)/$1C$alsanum$3/;
}
#
print $alsaname;
exit 0;
