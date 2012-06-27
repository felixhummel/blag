WPA2 Without Network Manager
============================
This shows how to configure roaming with WPA2-encrypted WLAN networks. The following is my adaption of https://zivwiki.uni-muenster.de/bin/view/Anleitungen/WirelessLANSetupDebian#3_WPA_configuration_for_roaming.

``/etc/network/interfaces`` (*ath1* is the wlan interface, *some_essid* and *another_essid* are "virtual interfaces" defined in ``/etc/wpa_supplicant/roam.conf``)::
    
    auto lo
    iface lo inet loopback

    auto ath1
    allow-hotplug ath1
    iface ath1 inet manual
        wpa-driver wext
        wpa-roam /etc/wpa_supplicant/roam.conf

    iface home inet dhcp
    iface uni inet dhcp

``/etc/wpa_supplicant/roam.conf``::

    ctrl_interface=/var/run/wpa_supplicant
    ctrl_interface_group=0
    ap_scan=1
    fast_reauth=1
    eapol_version=1
    network={
        id_str="home"
        ssid=<essid of my router>
        psk=<wpa_passphrase-generated-key>
        priority=5
    }
    network={
        id_str="uni"
        ssid=<essid of the university's router>
        psk=<wpa_passphrase-generated-key>
        priority=3
    }


Some Hints
----------
Manual control::

    ifup ath1  # brings up the pysical interface while redirecting control to wpa_supplicant
    wpa_cli  # type help or status...
    wpa_action home stop
    wpa_action uni reload
    # ...
