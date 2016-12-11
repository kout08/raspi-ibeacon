apt_install(){
	pkg=`dpkg -l | grep $1`
	if [ "$pkg" != "" ]; then
		echo "$1 is already exist"
	else
		echo "$1 is not exist. Start install."
		sudo apt-get install -y $1
	fi
}

# ex) wget_insatll "bluez-5.43.tar.xz" "https://www.kernel.org/pub/linux/bluetooth/bluez-5.43.tar.xz"
# $1: Install src name
# $2: Install URL
wget_install(){
	# $DIR: relative path of this project repo
	DIR=$(dirname $0)
	if [ -e "$DIR/$1" ]; then
		echo "$1 is already exist"
	else
		echo "$1 is not exist. Start install..."
		wget $2 -P $DIR
	fi
}

# ex) git_clone "bluez-ibeacon" "https://github.com/carsonmcdonald/bluez-ibeacon.git"
git_clone(){
	# $DIR: relative path of this project repo
	DIR=$(dirname $0)
	#DIR=$(cd $(dirname $0) && pwd)
	if [ -e "$DIR/$1" ]; then
		echo "$1 is already exist"
	else
		echo "$1 is not exist. Start install..."
		git clone $2 $DIR/$1
	fi
}

# ex) open_tar_xz "bluez-5.43.tar.xz" "bluez-5.43"
# $1: Open tar.xz file name
# $2: Open src name
open_tar_xz(){
	# $DIR: relative path of this project repo
	DIR=$(dirname $0)
	if [ -e "$DIR/$2" ]; then
		echo "$2 is already exist"
	else
		echo "$2 is not exist. Start open..."
		tar vJxf $DIR/$1 -C $DIR
	fi
}

apt_install libglib2.0-dev
apt_install libdbus-1-dev
apt_install libudev-dev
apt_install libical-dev
# apt_install libreadline6-dev

# sh path/sample/setup.sh
# $DIR: path/sample
wget_install "bluez-5.43.tar.xz" "https://www.kernel.org/pub/linux/bluetooth/bluez-5.43.tar.xz"
open_tar_xz "bluez-5.43.tar.xz" "bluez-5.43"
# cd bluez-5.43
# ./configure --disable-systemd --enable-library && make && sudo make install
git_clone "bluez-ibeacon" "https://github.com/carsonmcdonald/bluez-ibeacon.git"
# cd bluez-ibeacon/bluez-beacon
# make
# #Usage: ./beacon <advertisement time in ms> <UUID> <major number> <minor number> <RSSI calibration amount>
# sudo  ./ibeacon 200 0000000007711001B000001C4D143B52 1 1 -29
