apt_install(){
	pkg=`dpkg -l | grep $1`
	if [ "$pkg" != "" ]; then
		echo "$1 is already exist"
	else
		echo "$1 is not exist. Start install."
		sudo apt-get install -y $1
	fi
}

# wget_insatll "$HOME/ibeacon" "bluez-5.43.tar.xz"
wget_install(){
	if [ -e "$1/$2" ]; then
		echo "$2 is already exist"
		#echo "$target is already exist"
	else
		echo "$2 is not exist. Start install..."
		#echo "$target is not exist. Start install..."
		#wget https://www.kernel.org/pub/linux/bluetooth/bluez-5.43.tar.xz
	fi
}

open_tar.xzz(){
	if [ -e "$1/$2" ]; then
		echo "$2 is already exist"
		#echo "$target is already exist"
	else
		echo "$2 is not exist. Start open..."
		#echo "$target is not exist. Start install..."
		#tar vJxf bluez-5.43.tar.xz
	fi
}

apt_install libglib2.0-dev
apt_install libdbus-1-dev
apt_install libudev-dev
apt_install libical-dev
apt_install libreadline6-dev

wget_insatll "$HOME/ibeacon" "bluez-5.43.tar.xz" "
