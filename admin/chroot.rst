*****************************
Debootstrapping and Chrooting
*****************************
.. index:: ubuntu, bash

.. highlight:: bash
    :linenothreshold: 10

.. contents::

This article shows how to create a chroot environment. Why? --> http://en.wikipedia.org/wiki/Chroot#Uses

My initial use case was to set up Oracle Express - which only comes as a 32 bit package - on my 64 bit box::

    +------------------------+
    |      jaunty amd64      |
    |  +------------------+  |
    |  |   jaunty i386    |  |
    |  |  +------------+  |  |
    |  |  |   oracle   |  |  |
    |  |  +------------+  |  |
    |  +------------------+  |
    +------------------------+

We *will not* create a bootable system! If you want that, see

- :doc:`usb_ubuntu`

Prerequisites
=============
Get debootstrap (:ref:`what is wajig? <wajig>`)::

    wajig install debootstrap

Get admin rights to eliminate the need of typing sudo before every command::

    sudo bash

Debootstrap
===========
Create target directory::

    target_dir=/usr/local/mychroot
    mkdir $target_dir

Choose a release, i.e. the release code name. See http://archive.ubuntu.com/ubuntu/dists/ or http://www.debian.org/releases/::

    release=squeeze

Choose a fast mirror_ (debian_) *for your release* to increase debootstrap's download speed::

    mirror=ftp://ftp.fu-berlin.de/linux/ubuntu/releases/

.. _mirror: https://wiki.ubuntu.com/Mirrors
.. _debian: http://www.debian.org/mirror/list

Choose an architecture!  It is important to choose the right architecture in the next step. You probably want ``i386`` (aka. x86 aka. 32 bit) or ``amd64`` (aka. 64 bit). For a full list of supported architectures see http://archive.ubuntu.com/ubuntu/dists/jaunty/Release::

    arch=i386

And put it all together::

    debootstrap --arch $arch $release $target_dir

This takes a while. Upon completion, have a look::

    ls $target_dir

Mounting and Unmounting
=======================
Create and run the Bash script ``mountall``::

    cd /var/tmp  # or ~/bin if you like
    cat > mountall << EOF
    mount -t proc proc ${target_dir}/proc  # for bash completion
    mount --bind /dev ${target_dir}/dev
    mount -t sysfs sysfs ${target_dir}/sys
    EOF

    chmod +x mountall
    ./mountall

Create the Bash script ``umountall`` for later use::

    cat > umountall << EOF
    umount ${target_dir}/proc
    umount ${target_dir}/dev
    umount ${target_dir}/sys
    EOF

    chmod +x umountall

Chrooting
=========
::

    chroot $target_dir

Done. Now you can install packages, run servers, ...

Upon exiting the chroot, remember to unmount::

    /var/tmp/umountall

After Reboot
============
Just mount everyhing and chroot::

    /var/tmp/mountall
    chroot /usr/local/mychroot
