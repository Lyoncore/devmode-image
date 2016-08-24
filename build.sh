set -x

#https://people.canonical.com/~mvo/all-snaps/ubuntu-device-flash

TODAY=$(date +%Y%m%d)
MINOR_RELEASE=$1
PROJECT=$2
CHANNEL=$3
export UBUNTU_DEVICE_FLASH_IGNORE_UNSTABLE_GADGET_DEFINITION=1

if [ -z $CHANNEL ] ; then
	CHANNEL=edge
fi

./ubuntu-device-flash --verbose core 16 \
	--channel $CHANNEL \
	--size 4 \
	--enable-ssh \
	--gadget pc \
	--kernel pc-kernel \
	--os ubuntu-core \
	--install snapweb \
	--install bluez \
	--install network-manager \
	--install modem-manager \
	-o $PROJECT-$TODAY-$MINOR_RELEASE.img
	#--os ubuntu-core_16.04.1_amd64.snap \
