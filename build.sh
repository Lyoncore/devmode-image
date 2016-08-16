set -x

TODAY=$(date +%Y%m%d)
MINOR_RELEASE=$1
PROJECT=$2
CHANNEL=$3

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
	-o $PROJECT-$TODAY-$MINOR_RELEASE.img
