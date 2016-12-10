apt_install(){
	pkg=`dpkg -l | grep $1`
	if [ "$pkg" != "" ]; then
		echo "$1 is already exist"
	else
		echo "$1 is not exist. Start install."
		sudo apt-get install -y $1
	fi
}

# ex) wget_insatll "$HOME/ibeacon" "bluez-5.43.tar.xz" "https://www.kernel.org/pub/linux/bluetooth/bluez-5.43.tar.xz"
# $1: Install dir name
# $2: Install src name
# $3: Install URL
wget_install(){
	if [ -e "$1/$2" ]; then
		echo "$2 is already exist"
	else
		echo "$2 is not exist. Start install..."
		#wget https://www.kernel.org/pub/linux/bluetooth/bluez-5.43.tar.xz
		wget $3 -P $1
	fi
}

# ex) open_tar_xz "$DIR" "bluez-5.43.tar.xz" "bluez-5.43"
# $1: Open dir name
# $2: Open tar.xz file name
# $3: Open src name
open_tar_xz(){
	if [ -e "$1/$3" ]; then
		echo "$3 is already exist"
	else
		echo "$3 is not exist. Start open..."
		tar vJxf $1/$2 -C $1
	fi
}

apt_install libglib2.0-dev
# apt_install libdbus-1-dev
apt_install libudev-dev
apt_install libical-dev
apt_install libreadline6-dev

# sh path/sample/setup.sh
# $DIR: path/sample
DIR=$(dirname $0)
wget_install "$DIR" "bluez-5.43.tar.xz" "https://www.kernel.org/pub/linux/bluetooth/bluez-5.43.tar.xz"
open_tar_xz "$DIR" "bluez-5.43.tar.xz" "bluez-5.43"
