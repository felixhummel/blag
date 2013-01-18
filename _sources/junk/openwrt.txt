******************
OpenWRT on WRT54GL
******************
- domain name for lan: `lan`
- when setting up a new box, e.g. ubuntu-box, it should be reachable at `ubuntu-box.lan`
- should be possible to add subdomains (see `Subdomains with Dnsmasq`_)

Reset
=====
- remove power cable
- hold reset button
- insert power cable
- when DMZ led up: release reset button
- `telnet 192.168.1.1`

.. todo:: link wiki

White Russian to Backfire
=========================
::

    scp openwrt-brcm47xx-squashfs.trx md5sums root@192.168.1.1:
    ssh root@192.168.1.1
    md5sum -c md5sums
    mtd -r write openwrt-brcm47xx-squashfs.trx linux

wait for it...
::

    ping -i 2 192.168.1.1

Check out UCI
=============
http://wiki.openwrt.org/doc/uci

Configure DHCP
==============
- DSL-Router at 192.168.1.1
- wrt = DHCP Server = 192.168.1.2
- Network > Interfaces > LAN: for now: lease time 2m -- TODO: up to 72h
- default gateway (`wiki <http://wiki.openwrt.org/doc/uci/dhcp#dhcp.option.example.to.set.an.alternative.default.gateway>`__)

`/etc/config/dhcp`::

    config 'dhcp' 'lan'
            [...]
            list 'dhcp_option' '3,192.168.1.2'


Subdomains with Dnsmasq
-----------------------
Thanks, `Santiago <http://www.santiagolizardo.com/article/how-to-setup-wildcard-subdomains-in-linux/64001>`__!

Mission: Subdomains for `enterprise.lan` (192.168.1.3), e.g. `mail.enterprise.lan` or `www.enterprise.lan` ...

::

    vim /etc/dnsmasq.conf

For `enterprise.lan`, add the line::

    address=/enterprise.lan/192.168.1.3

Reload dnsmasq and try it (either locally or on another box)::

    /etc/init.d/dnsmasq reload
    nslookup www.enterprise.lan


