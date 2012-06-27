****
GRUB
****
GRUB is not installed
=====================
Error::

	GRUB Loading stage1.5.

	GRUB loading, please wait...
	Error 17

Solution
--------
Recovery-CD -> Root Shell::

	fdisk -l

to list all partitions. Remember ``/boot/``-Partition (e.g. ``/dev/sdb1``) and its GRUB-equivalent (``(hd1,0)`` in this case). Then::

	grub

to start GRUB's shell and feed it with::

	root (hd1,0)
	setup (hd1)
	quit

and reboot.

If Grub does *not* work after rebooting, simply press ``e`` in GRUB's boot menu to go to the edit mode of the boot entry. Press ``e`` again to change the line ``root (hdX,Y)`` to e.g. ``root (hd1,0)``. Press :kbd:`b` to boot with the new root partition.

Explanation
-----------
The right partition
^^^^^^^^^^^^^^^^^^^
... is wherever your ``/boot`` is. This command tells you::

    df /boot

The kernel's root argument
^^^^^^^^^^^^^^^^^^^^^^^^^^
... expects a path to the inititial ramdisk. If you have a seperate boot partition (which you should), then ``root=/<your-initramfs-file-name>`` is correct. ``/boot`` could also be a simple directory under ``/``. Then the kernel argument would be ``root=/boot/<your-initramfs-file-name>``

Sources
=======
http://ubuntuforums.org/showpost.php?p=117829&postcount=2 (GER)
