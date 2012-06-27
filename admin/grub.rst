****
GRUB
****
How to fix GRUB
===============
Recovery CD > Root Shell::

    fdisk -l

Remember the root partition (and boot partition, if you have one), then::

    grub

to start the GRUB shell and (for /dev/sda1 with no "hda"s and /boot on the root partition)::

    root(hd1,0)
    setup(hd1)
    quit

Restart. Done.
