#!/usr/bin/env bash

set -ex

id | grep root

DISK=$1
MODULES=$2
TMP=$(mktemp -d)
echo "$TMP"


mount -o loop "$DISK" "$TMP"

debootstrap bookworm "$TMP"

cp /bootstrap_disk_1.sh  "$TMP/"
fakechroot chroot "$TMP" bash /bootstrap_disk_1.sh


chroot "$TMP" update-alternatives --set iptables /usr/sbin/iptables-legacy
chroot "$TMP" update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy


rsync  -a "${MODULES}/" "$TMP/usr/lib/modules"
rsync  -a "${MODULES}_extra/" "$TMP/usr/lib/modules"
chown -R root:root "$TMP/usr/lib/modules"


umount "$TMP"