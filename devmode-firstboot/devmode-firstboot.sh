#!/bin/sh

set -x

cd /writable/system-data/var/lib/devmode-firstboot

for DEVMODESNAPS in *.snap ; do
	snap install --devmode $DEVMODESNAPS
done

snap connect modem-manager:mmcli modem-manager:service
snap connect network-manager:service modem-manager:service
snap connect network-manager:nmcli network-manager:service
snap connect bluez:client bluez:service
snap connect tpm:tpm ubuntu-core:tpm

touch /writable/system-data/var/lib/devmode-firstboot/devmode-firstboot.stamp

systemctl restart snap.network-manager.networkmanager
systemctl restart snap.modem-manager.modemmanager
systemctl restart snap.bluez.bluez
systemctl restart snap.bluez.obex

sed -i 's/After=snapd.frameworks.target/After=network-online.target snapd.frameworks.target/g' /etc/systemd/system/snap.snapweb.snapweb.service
sed -i 's/Requires=snapd.frameworks.target/Requires=network-online.target snapd.frameworks.target/g' /etc/systemd/system/snap.snapweb.snapweb.service

#reboot
