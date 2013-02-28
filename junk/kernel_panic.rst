Kernel Panic
============
2012-02-28: Kernel panic (blinking caps lock key).

- http://www.postgresql.org/message-id/201101022224.34365.andres@anarazel.de
- http://unix.stackexchange.com/questions/27449/mount-a-filesystem-read-only-and-redirect-writes-to-ram

``/etc/sysctl.conf``::

    kernel.yama.protected_nonaccess_hardlinks = 0

