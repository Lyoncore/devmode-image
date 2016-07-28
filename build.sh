set -x

#https://people.canonical.com/~mvo/all-snaps/ubuntu-device-flash

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
	--gadget demo-amd64 \
	--kernel canonical-pc-linux \
	--os ubuntu-core-122.snap \
	--install webdm \
	--install bluez \
	--install network-manager \
	-o $PROJECT-$TODAY-$MINOR_RELEASE.img
