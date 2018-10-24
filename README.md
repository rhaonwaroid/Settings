#------------------------------
#	Setting
#------------------------------
1. start config
	-[0] sudo raspi-config
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
	-[A] git clone https://github.com/rhaonwaroid/Settings.git
	-[A] cd settings/script
	-[A] ./initialize.sh
	-[A] sudo ./wifi.sh <station | ap>
	-[A] sudo reboot
	
3. test
	-[A] ifconfig -a
	-[A] iwconfig
	-[A] raspistill -o 1.jpg
	-[A] raspivid -o 1.h264
	-[A] rm 1.*
	-[A] gpio -v
	-[A] gpio readall
	
#------------------------------
#	Inistall Waroid Single 
#------------------------------
	-[A] cd Work
	-[A] git clone https://github.com/rhaonwaroid/WaroidSingle.git
	-[A] cd WaroidSingle
	-[A] make
	-[A] make install
	-[A] sudo vi /etc/rc.local
		=> using waroid single

#------------------------------
#	Clear Log
#------------------------------
	-[A] sudo truncate -s0 /var/log/waroid.log
	-[A] sudo truncate -s0 /var/log/syslog
	
#------------------------------
#	Download 8822bu driver
#------------------------------
	-[A] wget http://downloads.fars-robotics.net/wifi-drivers/8822bu-drivers/8822bu-4.14.34-1110.tar.gz
	
