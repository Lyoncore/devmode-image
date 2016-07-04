#!/bin/sh

set -x

cd /writable/system-data/var/lib/devmode-firstboot

snap refresh --channel=edge ubuntu-core
snap connect network-manager:nmcli network-manager:service
snap connect bluez:client bluez:service
snap connect webdm:network ubuntu-core:network
snap connect webdm:network-bind ubuntu-core:network-bind
snap connect webdm:snapd-control ubuntu-core:snapd-control

touch /writable/system-data/var/lib/devmode-firstboot/devmode-firstboot.stamp

systemctl restart snap.network-manager.networkmanager
systemctl restart snap.bluez.bluez
systemctl restart snap.bluez.obex
systemctl restart snap.webdm.snappyd

sed -i 's/After=snapd.frameworks.target/After=networking.service snapd.frameworks.target/g' /etc/systemd/system/snap.webdm.snappyd.service
sed -i 's/Requires=snapd.frameworks.target/Requires=networking.service snapd.frameworks.target/g' /etc/systemd/system/snap.webdm.snappyd.service

reboot
