LXC (LinuX Containers)
======================

Create
------
List templates::

    ls /usr/lib/lxc/templates/

Template help::

    lxc-create -t ubuntu -h

Create container "base" with precise and my ssh key::

    lxc-create -n base -t ubuntu -- --release precise --auth-key ~/.ssh/id_rsa.pub


Status / Management
-------------------
List::

    lxc-list


Run
---
Run as daemon (bug_ prevents detach)::

    lxc-start -n base -d

.. _bug: http://serverfault.com/questions/405482/how-to-disconnect-from-lxc-console

Attach to console exit with :kbd:`Control-a q`::

    lxc-console -n base

Print IPv4::

    awk '/base/ { print $3 }' /var/lib/misc/dnsmasq.leases

SSH::

    ip=$(awk '/base/ { print $3 }' /var/lib/misc/dnsmasq.leases)
    ssh ubuntu@$ip

Base Container
--------------
Locale::

    locale-gen en_US.UTF-8
    update-locale LANG=en_US.UTF-8

