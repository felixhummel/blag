Connecting to WPA2-Encrypted Networks
=====================================
This tutorial is for those, who like to know exactly what's going on. It shows how to connect to a WPA2-encrpted network manually and how to automate just enough of it to make it suitable for daily use while remaining geeky. Enjoy!

.. contents::

.. highlight:: bash

Hardcore Manual Way
-------------------
First, some assumptions:

1. Your network interface is called ``wlan0``.
2. You have wpa_supplicant installed.
3. You have a WPA2-protected WLAN at your disposal

There are three steps to get connected to your WLAN:

1. Get some data about your WLAN
2. Connect with wpa_supplicant
3. Get an IP-address and set your nameserver and default gateway

Listing Available WLANs
^^^^^^^^^^^^^^^^^^^^^^^
Simply type::

    sudo iwlist wlan0 scan

You'll see something like this::

    wlan0     Scan completed :
              Cell 01 - Address: 00:AB:CD:EF:01:23
                        Channel:7
                        Frequency:2.442 GHz (Channel 7)
                        Quality=52/70  Signal level=-58 dBm  
                        Encryption key:on
                        ESSID:"my_wlan"
                        Bit Rates:1 Mb/s; 2 Mb/s; 5.5 Mb/s; 11 Mb/s; 18 Mb/s
                                  24 Mb/s; 36 Mb/s; 54 Mb/s
                        Bit Rates:6 Mb/s; 9 Mb/s; 12 Mb/s; 48 Mb/s
                        Mode:Master
                        Extra:tsf=000003c295135189
                        Extra: Last beacon: 56ms ago
                        IE: IEEE 802.11i/WPA2 Version 1
                            Group Cipher : TKIP
                            Pairwise Ciphers (1) : TKIP
                            Authentication Suites (1) : PSK
                        IE: Unknown: 32040C121860
                        IE: Unknown: DD06001018020004
              Cell 02 - Address: 00:01:23:45:67:89
                        Channel:6
                        Frequency:2.437 GHz (Channel 6)
                        Quality=56/70  Signal level=-54 dBm  
                        Encryption key:on
                        ESSID:"another_wlan"
                        Bit Rates:1 Mb/s; 2 Mb/s; 5.5 Mb/s; 11 Mb/s; 6 Mb/s
                                  12 Mb/s; 24 Mb/s; 36 Mb/s
                        Bit Rates:9 Mb/s; 18 Mb/s; 48 Mb/s; 54 Mb/s
                        Mode:Master
                        Extra:tsf=000000c0d6bbe45e
                        Extra: Last beacon: 4100ms ago
                        IE: Unknown: DD0900037F0101001FFF7F
                        IE: WPA Version 1
                            Group Cipher : TKIP
                            Pairwise Ciphers (1) : TKIP
                            Authentication Suites (1) : PSK
                        IE: Unknown: DD1A00037F030100000000095BE87A1802095BE87A1864002C011F08

We're interested in ``cell0`` here. The following fields are noteworthy:

1. ``Address: 00:AB:CD:EF:01:23``
2. ``ESSID:"my_wlan"``
3. ``IE: IEEE 802.11i/WPA2 Version 1``

The address is the hardware address of your router, the essid is the name you gave your WLAN and the third field shows you that my_wlan is indeed encrypted with WPA2.

Connecting with wpa_supplicant
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
I prefer to write a config file to hold my networks, but it's also possible to provide options to wpa_supplicant - see ``man wpa_supplicant``. Here's a simple config file (``~/my_wlan.conf``)::

    ctrl_interface=/var/run/wpa_supplicant
    # my network (this is a comment)
    network={
        ssid="my_wlan"
        priority=5  
        key_mgmt=WPA-PSK
        group=CCMP TKIP 
        psk="secret"
    }                        

Connecting is easy now::

    iface=wlan0
    driver=wext  # works for most chipsets
    config=~/my_wlan.conf

    wpa_supplicant -i$iface -D$driver -c$config

You are now connected to your WLAN. Note that wpa_supplicant remains in the forground - don't close your terminal.

Getting IP Address, Gateway and Nameserver
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If you have DHCP activated on your router, simply run::

    iface=wlan0

    sudo dhclient $iface

If not, then run::

    iface=wlan0
    my_ip=192.168.0.123
    netmask=255.255.255.0
    gateway=192.168.0.254

    sudo ifconfig $iface $my_ip netmask $netmask up
    sudo route add default gw $gateway

Disconnecting
^^^^^^^^^^^^^
Assuming you used DHCP::

    iface=wlan0
    sudo dhclient -r $iface
    sudo killall wpa_supplicant  # or simply close the running instance

Using Debian's ifup/down
------------------------
This is the way I do it. In the end, my wlan starts automatically and I can control it with ``sudo ifup wlan0`` and ``sudo ifdown wlan0``. To do this, We will

1. create a config file for wpa_supplicant,
2. edit ``/etc/network/interfaces`` and
3. try it out.

First, see my config above or read ``man wpa_supplicant.conf``.

/etc/network/interfaces::

    auto lo
    iface lo inet loopback

    auto wlan0
    iface wlan0 inet dhcp
        pre-up wpa_supplicant -B -Dwext -iwlan0 -c/home/me/my_wlans.conf
        post-down killall -q wpa_supplicant

Try it::

    sudo ifup wlan0
    sudo ifdown wlan0

You should see the output from ``dhclient``.
