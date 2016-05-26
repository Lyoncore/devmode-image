#!/bin/sh

set -e
set -x

cleanup()
{
	if [ -n "$IMAGE_LOOP" ]; then
	#	for part in /dev/mapper/${IMAGE_LOOP}* /dev/${IMAGE_LOOP}p*; do
	#		umount $part 2>/dev/null || true
	#	done
	#	kpartx -d /dev/$IMAGE_LOOP || true
		umount $TMPDIR/image/writable
		losetup -d /dev/$IMAGE_LOOP || true
	fi
	if [ -n "$TMPDIR" ]; then
		rm -rf $TMPDIR
	fi
}

IMAGE="$1"
if [ -z "$IMAGE" ]; then
	cat <<EOF
usage: $0 <image>
EOF
	exit 1
fi

# TODO: check image and device

trap "cleanup" EXIT HUP INT QUIT TERM

# setup a rw loopback device to update base image
IMAGE_LOOP="$(losetup --find --show "$IMAGE" -o $((147456*512)) | xargs basename)"
#losetup /dev/loop0 "$IMAGE" -o $((147456*512))
#kpartx -a /dev/$IMAGE_LOOP
udevadm settle

TMPDIR=$(mktemp -d)

echo "[mount image partitions on ${IMAGE_LOOP}]"
#for part in /dev/mapper/${IMAGE_LOOP}*; do
#	label="$(blkid $part -o value -s LABEL)" || continue
#	if [ "$label" = "writable" ]; then
#		mkdir -p $TMPDIR/image/"$label"
#		mount $part $TMPDIR/image/"$label"
#	fi
#done

mkdir -p $TMPDIR/image/writable
mount /dev/$IMAGE_LOOP $TMPDIR/image/writable

cp -r devmode-firstboot $TMPDIR/image/writable/system-data/var/lib/
cp -f devmode-firstboot/devmode-firstboot.service $TMPDIR/image/writable/system-data/etc/systemd/system/
ln -s /lib/systemd/system/devmode-firstboot.service $TMPDIR/image/writable/system-data/etc/systemd/system/multi-user.target.wants/devmode-firstboot.service

