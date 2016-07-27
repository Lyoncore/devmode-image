set -x

#https://people.canonical.com/~mvo/all-snaps/ubuntu-device-flash
#rm ubuntu-core-*.snap
#amd64_os_snap=https://public.apps.ubuntu.com/anon/download-snap/b8X2psL1ryVrPt5WEmpYiqfr5emixTd7_122.snap
#os_snap_file=$(basename $amd64_os_snap)

#wget $amd64_os_snap
#mv $os_snap_file ubuntu-core-122.snap

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
	--gadget canonical-pc \
	--kernel canonical-pc-linux \
	--os ubuntu-core-122.snap \
	--install webdm \
	--install bluez \
	--install network-manager \
	-o $PROJECT-$TODAY-$MINOR_RELEASE.img
