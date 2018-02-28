#------------------------------
#	Setting
#------------------------------
1. start config
	-[A] sudo raspi-config
		Change User Password -> ????
		Network Options -> Hostname -> DEV-0W or BACKUP-0W or DEV-DRIVER
		Network Options -> Wi-fi -> waroid-2.4g -> 12345678 
		Boot Options -> Desktop / CLI -> Console Autologin
		Localisation Options -> Change Timezone -> Asia -> Seoul
		Localisation Options -> Change Keyboard Layout -> Generic 105-key (Intl) PC -> Other -> Korean -> Korean - Korean (101/104 key compatible) - The default for the keyboard layout -> No compose key
		Interfacing Options -> Camera -> Yes
		Interfacing Options -> SSH -> Yes
		Interfacing Options -> Serial -> No -> Yes
		Advanced Options -> Expand Filesystem
		Advanced Options -> Audio -> Force 3.5mm
	
2. update and upgrade
	-[A] sudo apt-get update
	-[A] sudo apt-get upgrade
	-[A] sudo apt-get install git
	-[A] mkdir Work && cd Work
	-[A] git clone https://github.com/waroid/settings.git
	-[A] cd settings/driver
	-[0] tar xvzf 8822bu-4.9.59-1047.tar.gz
	-[A] ./install.sh
	-[A] sudo reboot

3. update config
	-[A] cd Work/settings/script
	-[A] ./intialize.sh
	-[A] sudo ./wifi.sh <station | ap>
	-[A] sudo reboot
	
4. test
	-[A] ifconfig -a
	-[A] iwconfig
	-[A] raspistill -o 1.jpg
	-[A] raspivid -o 1.h264
	-[A] rm 1.*
	-[A] gpio -v
	-[A] gpio readall
	

#------------------------------
#	Inistall Waroid Mulit 
#------------------------------
	-[A] cd Work
	-[A] git clone https://github.com/rhaon/WaroidMulit.git
	-[A] cd WaroidMulti
	-[A] make
	-[A] make install
	-[A] sudo vi /etc/rc.local
		=> using waroid multi
		=> set server ip
		
#------------------------------
#	Inistall Waroid Single 
#------------------------------
	-[A] cd Work
	-[A] git clone https://github.com/rhaon/WaroidSingle.git
	-[A] cd WaroidSingle
	-[A] make
	-[A] make install
	-[A] sudo vi /etc/rc.local
		=> using waroid single

#------------------------------
#	Syslog
#------------------------------
	-[A] sudo apt-get install syslog-ng
	-[A] sudo touch /var/log/waroid.log
	-[0] cd Work/settings/0
	-[A] sudo cp etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
	-[A] sudo systemctl restart syslog-ng.service

#------------------------------	
#	NEXT 510AC mini driver
#------------------------------
	-[A] cd Work/settings/driver
	-[0] tar xzf 8812au-4.9.41-1023.tar.gz (download: wget http://www.fars-robotics.net/8812au-4.9.41-1023.tar.gz)
	-[0] tar xzf 8812au-4.9.41-1023.tar.gz (download: wget http://www.fars-robotics.net/8812au-4.9.59-1047.tar.gz)
	-[2] tar xzf 8812au-4.9.41-v7-1023.tar.gz (download: wget http://www.fars-robotics.net/8812au-4.9.41-v7-1023.tar.gz)
	-[A] ./install.sh
	-[A] sudo reboot
	
#------------------------------
#	EDIMAX EW 7822ULC
#------------------------------
	-[A] cd Work/settings/driver
	-[0] tar xzf 8822bu-4.9.41-1023.tar.gz (kernel compile)
	-[A] ./install.sh
	
#------------------------------
#	Bluetooth
#------------------------------
	-[0] cd Work/settings/0
	-[0] sudo cp etc/systemd/system/bluetooth.target.wants/bluetooth.service /etc/systemd/system/bluetooth.target.wants/bluetooth.service
	-[0] sudo cp etc/systemd/system/rfcomm.service /etc/systemd/system/rfcomm.service
	-[0] sudo reboot
	
	-[0] sudo bluetoothctl
		agent on
		default-agent
		discoverable on
		scan on
		pair C0:33:5E:34:7D:FA
		trust C0:33:5E:34:7D:FA
	
#------------------------------
# Python serial
#------------------------------
	-[A] sudo apt-get install python-serial

#------------------------------	
# GStreamer
#------------------------------
	-[A] sudo apt-get install gstreamer1.0-tools
	-[A] sudo apt-get install gstreamer1.0-plugins-bad
	-[A] sudo apt-get install gstreamer1.0-plugins-good

#------------------------------
# log clear
#------------------------------
	-[A] sudo truncate -s0 /var/log/waroid.log
	-[A] sudo truncate -s0 /var/log/syslog
	