#!/bin/bash

if [ "$EUID" -ne 0 ]
then 
	echo "Must be root"
	exit
fi

if [[ $# -lt 1 ]]
then
	echo "You need to pass a wifi mode!"
	echo "Usage:"
	echo "sudo $0 <station|ap>"
	exit
fi

_WIFI_MODE="$1"
if [ "$_WIFI_MODE" != "station" -a "$_WIFI_MODE" != "ap" ]
then
	echo "$_WIFI_MODE is unknown."
	echo "Usage:"
	echo "sudo $0 <station|ap>"
	exit
fi

cp ../0/etc/network/interfaces /etc/network/interfaces

if [ "$_WIFI_MODE" = "station" ]
then
	cat >> /etc/network/interfaces << EOF
allow-hotplug wlan1
iface wlan1 inet manual
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf
iface robot inet dhcp
EOF
	
	systemctl disable dnsmasq
else
	cat >> /etc/network/interfaces << EOF
allow-hotplug wlan1
iface wlan1 inet static
address 10.1.1.1
netmask 255.255.255.0
network 10.1.1.0
broadcast 10.1.1.255
hostapd /etc/hostapd/hostapd.conf
EOF
	
	systemctl enable dnsmasq
fi

echo "All donw! please reboot"
