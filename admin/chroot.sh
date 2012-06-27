#!/bin/bash
# Creates a chroot environment
# read this and use it only if you know what you are doing!

sudo bash

# ---------------------
# configure this!
# ---------------------

# new environment will be at:
target_dir=
# mount and umount scripts will be at:
script_dir=
# see /usr/share/debootstrap/scripts/ and http://releases.ubuntu.com/ or http://www.debian.org/releases/
release=lucid
# ubuntu: https://wiki.ubuntu.com/Mirrors
mirror=ftp://ftp.fu-berlin.de/linux/ubuntu/releases/
arch=i386

mkdir -p $target_dir
debootstrap --arch $arch $release $target_dir $mirror

# MOUNT SCRIPTS
cat > $script_dir/mountall << EOF
mount -t proc proc ${target_dir}/proc  # for bash completion
mount --bind /dev ${target_dir}/dev
mount -t sysfs sysfs ${target_dir}/sys
EOF

chmod +x $script_dir/mountall

cat > $script_dir/umountall << EOF
umount ${target_dir}/proc
umount ${target_dir}/dev
umount ${target_dir}/sys
EOF

chmod +x $script_dir/umountall
