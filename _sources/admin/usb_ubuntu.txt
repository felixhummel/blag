******************************************************
Installing Ubuntu 8.10 on a USB Drive with Debootstrap
******************************************************
.. index:: ubuntu, bash

.. highlight:: bash
    :linenothreshold: 10

.. contents::

We will install Ubuntu on a USB drive without leaving our current Ubuntu installation.

My USB drive is ``/dev/sde`` and I create the chroot directory at ``/tmp/target``. Have fun and good luck!

Your Skills
===========
- You can partition a hard drive and
- you can install packages and
- you like the command line.

Prerequisites
=============
Get debootstrap (see :ref:`wajig`)::

    wajig install debootstrap

Get admin rights to eliminate the need of typing sudo before every command::

    sudo bash

Partitioning
============
``/dev/sde`` is the usb drive. Create the following partitions:

+-------------+-------------+---------+
| device      | mount point | size    |
+=============+=============+=========+
| /dev/sde1   | /boot       | 50M     |
+-------------+-------------+---------+
| /dev/sde2   | /           | 10G     |
+-------------+-------------+---------+
| /dev/sde3   | swap        | 1G      |
+-------------+-------------+---------+
| /dev/sde4   | /home       | ...     |
+-------------+-------------+---------+

Remember to make ``/dev/sde1`` bootable!

Formatting
==========
Plain ext2 Boot Partition
-------------------------
*/boot* should be a regular ext2 file system::

    mke2fs -L boot /dev/sde1

Root, Swap, Home
----------------
Any file system will do::

    mkfs.ext3 -L root /dev/sde2
    mkswap -L swap /dev/sde3
    mkfs.ext3 -L home /dev/sde4

Tune2fs
-------
You *could* disable file system checks if you wanted to::

    tune2fs -c 0 -i 0 /dev/sde1
    tune2fs -c 0 -i 0 /dev/sde2
    tune2fs -c 0 -i 0 /dev/sde4

Check Partitions
----------------
::

    fdisk -l /dev/sde

Mounting and Unmounting
=======================
Create and run the Bash script ``mountall``::

    cat > mountall << EOF
    mkdir -p /tmp/target/
    mount /dev/sde2 /tmp/target/

    mkdir -p /tmp/target/boot
    mount /dev/sde1 /tmp/target/boot

    mkdir -p /tmp/target/home
    mount /dev/sde4 /tmp/target/home

    mkdir /tmp/target/{proc,dev,sys}
    mount -t proc proc /tmp/target/proc  # for bash completion
    mount --bind /dev /tmp/target/dev
    mount -t sysfs sysfs /tmp/target/sys
    EOF

    chmod +x mountall
    ./mountall

Create the Bash script ``umountall`` for later use::

    cat > umountall << EOF
    umount /tmp/target/proc  # for bash completion
    umount /tmp/target/dev
    umount /tmp/target/sys

    umount /tmp/target/home
    umount /tmp/target/boot
    umount /tmp/target/
    EOF

    chmod +x umountall

Check that everything is mounted::

    mount | grep /dev/sde

Debootstrap
===========
Choose a fast mirror_ and a target architecture to increase debootstrap's download speed and install the base system::

    release=intrepid
    target=/tmp/target
    mirror=http://de.archive.ubuntu.com/ubuntu/
    target_arch=i386

    debootstrap --arch $target_arch $release $target $mirror

.. _mirror: https://wiki.ubuntu.com/Mirrors

.. note::

    It is important to choose the right architecture in the next step. You probably
    want ``i386`` or ``amd64``. For a full list of supported architectures see
    http://archive.ubuntu.com/ubuntu/dists/jaunty/Release

New Hostname
------------
::

    new_hostname=port
    cat > /tmp/target/etc/hostname << EOF
    $new_hostname
    EOF
    cat > /tmp/target/etc/hosts <<EOF
    127.0.0.1       localhost
    127.0.0.1       $new_hostname
    EOF


Fstab
-----
Let's get uuids and check them::

    boot_uuid=$(vol_id /dev/sde1 | grep UUID= | cut -d= -f2)
    root_uuid=$(vol_id /dev/sde2 | grep UUID= | cut -d= -f2)
    home_uuid=$(vol_id /dev/sde4 | grep UUID= | cut -d= -f2)

    echo $boot_uuid
    echo $root_uuid
    echo $home_uuid

``fstab`` (the indentation will be proper after uuid substitution)::

    cat > /tmp/target/etc/fstab <<EOF
    # device                                    mount   type options freq passno
    UUID=$root_uuid   /       ext3 defaults,errors=remount-ro 0 1
    UUID=$boot_uuid   /boot   ext2 defaults   0 1
    UUID=$home_uuid   /home   ext3 defaults   0 0
    EOF

.. todo:: fix swap problem

Root UUID
---------
We'll need *root_uuid* in the chroot environment::

    mkdir -p /tmp/target/tmp
    echo $root_uuid > /tmp/target/tmp/root_uuid

Chrooting
=========
::

    chroot /tmp/target

Set the time zone and update the system (ignore the perl locale warnings)::

    cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime

    # add universe repository for wajig and python-optcomplete
    echo `cat /etc/apt/sources.list` universe > /etc/apt/sources.list

    apt-get update
    apt-get dist-upgrade

Install the kernel, GRUB, completion tools and the terminal mouse server::

    apt-get install -y\
        initramfs-tools\
        grub
    
    apt-get install -y\
        linux-image-generic\
        vim bash-completion wajig python-optcomplete gpm

Enable root login::

    passwd

Configuring the Boot Loader
---------------------------
Remember the uuid of */* (select with mouse). That's why we copied it in `Root UUID`_::

    cat /tmp/root_uuid

Let ``update-grub`` create a menu.lst, then customize it::

    mkdir /boot/grub  # else, update-grub won't create /boot/grub/menu.lst
    update-grub
    vim /boot/grub/menu.lst

Uncomment and edit::

    timeout     9

Comment this line::

    #hiddenmenu

Uncomment and edit::

    color green/black black/green

Do **not** uncomment, but edit the following::

    kopt=root=UUID=
    alternative=false
    defoptions=vga=791
    updatedefaultentry=true

Exit the chroot::

    exit

Making It Bootable
==================
MBR::

    grub-install --root-directory=/tmp/target --no-floppy --recheck /dev/sde

You can remove all drives except ``(hd0)`` from ``/tmp/target/boot/grub/device.map``.

Unmount::

    ./umountall

That's it! Exit the "sudo bash"::

    exit

Troubleshooting
===============
GRUB
----
See also http://www.gnu.org/software/grub/manual/grub.html#Troubleshooting.

15 : File not found
^^^^^^^^^^^^^^^^^^^
- Check if ``vmlinuz-<kernel-version>`` exists in ``/boot``
- Check kernel line. Should be ``kernel /vmlinuz-<kernel-version> root=UUID=<root_uuid> vga=791``, because :file:`/boot` has it's own partition. If it is just a directory under :file:`/`, it should read ``kernel /boot/vmlinuz-<kernel-version> root=UUID=<root_uuid> vga=791``.

17 : Cannot mount selected partition
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Play with ``root (hd<disk-number>,<partition-number>``. GRUB will show you ``21 : Selected disk does not exist`` or ``22 : No such partition`` when you try a disk/partition that does not exist.

Ramdisk Image
-------------
thanks, skrewz [#ramdiskcheck]_::

    kernel_version=2.6.28-11-generic
    cd /tmp && rm -Rf w; mkdir w && cd w && cp /tmp/target/boot/initrd.img-$kernel_version i.cpio.gz && gunzip i.cpio.gz && cpio --extract --file=i.cpio && rm i.cpio
    ls

Further Reading
===============
.. [#articles] Articles can be found on pendrivelinux_ or through Google_; there are even some "official" tools_.
.. [#cryptsetup] https://help.ubuntu.com/community/FeistyEncryptedRootWithInstaller/#Chroot%20and%20configure
.. [#ramdiskcheck] See "4. The Initial Ramdisk Image" on http://howto.tjekke.skrewz.dk/encrypted-root.html

.. _pendrivelinux: http://www.pendrivelinux.com/
.. _Google: http://www.google.de/search?q=usb+ubuntu
.. _tools: https://help.ubuntu.com/community/Installation/FromUSBStick#Automatic%20Approaches
.. _UUID: http://en.wikipedia.org/wiki/Uuid
.. _Setting up an Encrypted Debian System: http://linuxgazette.net/140/kapil.html
.. _Minimal Ubuntu 8.04 Server Install: http://www.howtoforge.com/minimal-ubuntu-8.04-server-install

