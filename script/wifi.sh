#!/bin/bash

if [ "$EUID" -ne 0 ]
then 
	echo "Must be root"
	exit
fi

if [[ $# -lt 2 ]]
then
	echo "You need to pass a wifi mode!"
	echo "Usage:"
	echo "sudo $0 <station|ap>" "<2.4g|5g>"
	exit
fi

_WIFI_MODE="$1"
_WIFI_SPEED="$2"

if [ "$_WIFI_MODE" != "station" -a "$_WIFI_MODE" != "ap" ]
then
	echo "$_WIFI_MODE is unknown."
	echo "Usage:"
	echo "sudo $0 <station|ap>" "<2.4g|5g>"
	exit
fi

if [ "$_WIFI_SPEED" != "2.4g" -a "$_WIFI_SPEED" != "5g" ]
then
	echo "$_WIFI_SPEED is unknown."
	echo "Usage:"
	echo "sudo $0 <station|ap>" "<2.4g|5g>"
	exit
fi

cp ../0/etc/network/interfaces /etc/network/interfaces
cp ../0/etc/dnsmasq.conf /etc/dnsmasq.conf

if [ "$_WIFI_MODE" = "station" ]
then
	if [ "$_WIFI_SPEED" = "2.4g" ]
	then
		cat >> /etc/network/interfaces << EOF
allow-hotplug wlan0
iface wlan0 inet manual
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf
iface control inet dhcp
EOF
	else
		cat >> /etc/network/interfaces << EOF
allow-hotplug wlan1
iface wlan1 inet manual
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf
iface robot inet dhcp
EOF
	fi
	
	systemctl disable dnsmasq
else
	if [ "$_WIFI_SPEED" = "2.4g" ]
	then
		cat >> /etc/network/interfaces << EOF
allow-hotplug wlan0
iface wlan0 inet static
address 10.1.1.1
netmask 255.255.255.0
network 10.1.1.0
broadcast 10.1.1.255
hostapd /etc/hostapd/hostapd24g.conf
EOF

		cat >> /etc/dnsmasq.conf << EOF
interface=wlan0
dhcp-range=10.1.1.2,10.1.1.254,255.255.255.0,6h
EOF
	else
		cat >> /etc/network/interfaces << EOF
allow-hotplug wlan1
iface wlan1 inet static
address 10.1.1.1
netmask 255.255.255.0
network 10.1.1.0
broadcast 10.1.1.255
hostapd /etc/hostapd/hostapd5g.conf
EOF

		cat >> /etc/dnsmasq.conf << EOF
interface=wlan1
dhcp-range=10.1.1.2,10.1.1.254,255.255.255.0,6h
EOF
	fi
	
	systemctl enable dnsmasq
fi

echo "All donw! please reboot"
