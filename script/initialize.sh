#!/bin/bash

sudo apt-get install wiringpi libasound2 libasound2-dev libsndfile1 libsndfile1-dev libttspico-utils syslog-ng hostapd dnsmasq -y

sudo cp ../0/boot/config.txt /boot/config.txt
sudo cp ../0/etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
sudo cp ../0/etc/default/hostapd /etc/default/hostapd
sudo cp ../0/etc/hostapd/hostapd24g.conf /etc/hostapd/hostapd24g.conf
sudo cp ../0/etc/hostapd/hostapd5g.conf /etc/hostapd/hostapd5g.conf
sudo cp ../0/etc/network/interfaces /etc/network/interfaces
sudo cp ../0/etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
sudo cp ../0/etc/dnsmasq.conf /etc/dnsmasq.conf
sudo cp ../0/etc/rc.local /etc/rc.local
sudo cp ../0/lib/udev/rules.d/40-usb_modeswitch.rules /lib/udev/rules.d/40-usb_modeswitch.rules

sudo touch /var/log/waroid.log

sudo systemctl disable dhcpcd
sudo systemctl disable bluetooth
sudo systemctl disable hostapd
sudo systemctl disable dnsmasq

echo "All donw! please run wifi mode"
