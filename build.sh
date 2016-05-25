set -x

#https://people.canonical.com/~mvo/all-snaps/ubuntu-device-flash

sudo ./ubuntu-device-flash core 16 -o havasu.img --gadget=canonical-pc --kernel=canonical-pc-linux --os ubuntu-core --size 4 \
--enable-ssh --developer-mode --channel=edge


