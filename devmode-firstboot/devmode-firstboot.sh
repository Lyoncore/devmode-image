#!/bin/sh

set -x

cd /writable/system-data/var/lib/devmode-firstboot

cp bluetooth.conf /writable/system-data/etc/dbus-1/system.d/
cp org.freedesktop.NetworkManager.conf /writable/system-data/etc/dbus-1/system.d/

for DEVMODESNAPS in *.snap ; do
	snap install --devmode $DEVMODESNAPS
done

touch /writable/system-data/var/lib/devmode-firstboot.stamp
