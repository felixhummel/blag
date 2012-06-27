Network Management Disabled
===========================
::

    service network-manager stop
    rm /var/lib/NetworkManager/NetworkManager.state
    service network-manager start

