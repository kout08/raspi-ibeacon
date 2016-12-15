#! /bin/bash
# $DIR: absolute path of this project repo
DIR=$(cd $(dirname $0) && pwd)
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
	# DIR=$(dirname $0)
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
	# DIR=$(dirname $0)
	# DIR=$(cd $(dirname $0) && pwd)
	if [ -e "$DIR/$1" ]; then
		echo "$1 is already exist"
	else
		echo "$1 is not exist. Start install..."
		# git clone $2 $DIR/$1
	fi
}

# ex) open_tar_xz "bluez-5.43.tar.xz" "bluez-5.43"
# $1: Open tar.xz file name
# $2: Open src name
open_tar_xz(){
	# $DIR: relative path of this project repo
	# DIR=$(dirname $0)
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
apt_install ruby

# sh path/sample/setup.sh
# $DIR: path/sample
BLUEZ="bluez-5.43"
wget_install "$BLUEZ.tar.xz" "https://www.kernel.org/pub/linux/bluetooth/$BLUEZ.tar.xz"
open_tar_xz "$BLUEZ.tar.xz" "$BLUEZ"
BLUEZ_IBEACON=bluez-ibeacon
git_clone "$BLUEZ_IBEACON" "https://github.com/carsonmcdonald/$BLUEZ_IBEACON.git"
# #Usage: ./beacon <advertisement time in ms> <UUID> <major number> <minor number> <RSSI calibration amount>
# sudo  ./bluez-ibeacon/bluez-beacon/ibeacon 200 0000000007711001B000001C4D143B52 1 1 -29

# Initialize bluez make flag
isInstallFlagPath=$(dirname $0)/.IS_MAKE_FLAG__bluez.txt
isInstallFlagOrgPath=$(dirname $0)/.is_make_flag_org.txt

if [ ! -e "$isInstallFlagPath" ]; then
	echo "$isInstallFlagPath doesn't exists. Make new flag : $isInstallFlagPath"
	cp $isInstallFlagOrgPath $isInstallFlagPath
fi

if [ -e "$isInstallFlagPath" ]; then
	echo "$isInstallFlagPath is exists. Read install flag"
	# isInstallFlagPathの中にある変数を展開
	. $isInstallFlagPath
fi

if [ -e "$DIR/$BLUEZ" ]; then
	if [ $IS_MAKE_FLAG != 0 ]; then
		echo "Don't need to make $BLUEZ"
	else
		echo "Start setup $BLUEZ : configure & make & make install"
		cd $DIR/$BLUEZ
		./configure --disable-systemd --enable-library && make && sudo make install && cd $DIR && echo 'IS_MAKE_FLAG=1' > $isInstallFlagPath

		# test code
		# cd $DIR && echo 'IS_MAKE_FLAG=1' > $isInstallFlagPath

		. $isInstallFlagPath
	fi
else
	echo "$DIR/$BLUEZ doesn't exists"
fi

BLUEZ_BEACON=$BLUEZ_IBEACON/bluez-beacon
if [ -e "$DIR/$BLUEZ_BEACON" ]; then
	if [ $IS_MAKE_FLAG != 1 ]; then
		echo "Don't need to make $BLUEZ_BEACON"
	else
		echo "Start setup $BLUEZ_BEACON : make"
		cd $DIR/$BLUEZ_BEACON
		make && cd $DIR && echo 'IS_MAKE_FLAG=2' > $isInstallFlagPath

		# test code
		# cd $DIR && echo 'IS_MAKE_FLAG=2' > $isInstallFlagPath

		. $isInstallFlagPath
	fi
else
	echo "$DIR/$BLUEZ_BEACON doesn't exists"
fi
