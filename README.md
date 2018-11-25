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
#	Install Wifi driver
#------------------------------
	-[A] cd Work/Settings/driver
	-[0] tar xzf 8822bu-4.14.34-1110.tar.gz (EDIMAX EW 7822ULC) (downlaod from www.fars-robotics.net)
	-[0] tar xzf 8812au-4.14.34-1110.tar.gz (NEXT 510AC mini)	(downlaod from www.fars-robotics.net)
	-[0] tar xzf 8821cu-4.14.34-1110.tar.gz (AC600 from driver)	(build)
	-[A] ./install.sh	
	
#------------------------------
#	Mode Switch AC600
#------------------------------
	-[A] lsusb
	-[A] if 0bda:1a2b then sudo usb_modeswitch -KW -v 0bda -p 1a2b
	-[A] lsusb

#------------------------------
#	Build AC600 from driver
#------------------------------
	-[A] sudo apt-get install raspberrypi-kernel-headers
	-[A] git clone https://github.com/whitebatman2/rtl8821cu.git
	-[A] cd rtl8821
	-[A] vi Makefile
		-> EXTRA_CFLAGS += -Wno-date-time
		-> CONFIG_PLATFORM_I386_PC = n
		-> CONFIG_PLATFORM_ARM_RPI = y
		-> CONFIG_PLATFORM_ARM_RPI3 = n
	-[A] make
	-[A] sudo make install
