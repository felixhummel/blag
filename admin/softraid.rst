Soft Raid 1 on Ubuntu 12.04 with GPT disks
==========================================
prerequisites::

    wajig install gdisk mdadm lvm2

Create Partitions
-----------------
We will use one partition per device with maximum size.

create partitions::

    wajig install gdisk
    gdisk /dev/sdc
    # create a new empty GUID partition table (GPT)
    o
    y
    w
    y
    # add a new partition (type: Linux RAID)
    a
    <ENTER>
    <ENTER>
    <ENTER>
    fd00
    w
    y
    <ENTER>

reboot.

check::

    gdisk -l /dev/sdc

same for /dev/sdd.

find partition uuids::

    ls -la /dev/disk/by-partuuid/

Setup RAID1
-----------
watch raid (md) logging::

    tail -f /var/log/syslog
    watch cat /proc/mdstat

setup raid1::

    mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sdc1 /dev/sdd1
    y

add to config (http://wiki.ubuntuusers.de/Software-RAID#mdadm-conf-aktualisieren)::

    DEVICE /dev/disk/by-partuuid/8500f8db-b3e8-4b26-ac30-51b8d0b731dd /dev/disk/by-partuuid/2333aceb-a287-49c7-95f2-848321bb95c1
    ARRAY /dev/md0 metadata=1.2 name=locutus:0 UUID=25f29ab9:89f6e9e7:19f083c1:bc9b2d06




http://www.gagme.com/greg/linux/raid-lvm.php

- ~65000 extends per LV
- 256MB physical extend size (12TB storage: 12000000MB / 65000 ~ 182 MB)


setup lvm:

    pvcreate /dev/sdc1
    vgcreate raid /dev/sdc1
    

