*********************
VMWare and VirtualBox
*********************
Static IP on Linux Host (Virtualbox, Bridged)
=============================================
Goal: make virtual machine (guest) available to on your LAN

`Way 1`_: change VM and router (dhcp server, dns server) settings, aka. "I own this place"

    - the good: any PC on your LAN can access the VM under its name
    - the bad: you need full control over dhcp and dns in your network

`Way 2`_: change VM only

    - the good: easy setup
    - the bad: machines other that the host can access the guest only via its IP address

Way 1
-----
1. change network settings of VM

   - Bridged
   - choose host interface that's connected to the LAN
   - (if you did this before, click "settings symbol" and set old MAC address (see ifconfig of guest))

2. set "static" IP address

   - go to your DHCP server
   - set reserved IP for guest's MAC address
   - (set name for guest's "static" IP address)

3. boot VM, start ethernet with dhcp

   - e.g. via ``/etc/network/interfaces``
   - ``ifdown eth0``
   - ``ifup eth0``

Way 2
-----
1. do `Way 1`_, step 1
2. set static IP-address on guest **in same subnet as host**
3. adapt ``/etc/hosts`` on host
 

Static IP on Linux Host (VMWare, NAT)
=====================================
- Linux host running Ubuntu 9.10
- Linux guest *tsvm* running Ubuntu 8.04 server

Mission:

1. make tsvm (guest) accessible **to host only** via a static IP
2. be able to copy tsvm to another host and repeat 1)

Set Static MAC Address
----------------------
Edit `tsvm.vmx`, delete those lines::

    ethernet[n].generatedAddress
    ethernet[n].addressType
    ethernet[n].generatedAddressOffset

Add this line::

    ethernet0.address = "00:50:56:00:13:37"

You can set another MAC address. It must have the form "00:50:56:XX:YY:ZZ" with XX between 00 and 3F and YY and ZZ between 00 and FF. (hex of course)

From http://www.vmware.com/support/gsx3/doc/network_macaddr_gsx.html

Set Static Device Name
----------------------
::

    find /etc/udev/rules.d/ -name "*-net.rules" -exec rm {} \;
    echo 'KERNEL=="eth*", SYSFS{address}=="00:50:56:00:13:37", NAME="eth"' >        /etc/udev/rules.d/10-net.rules

vim /etc/network/interfaces::

    auto lo
    iface lo inet loopback
    auto eth
    iface eth inet dhcp

Set Static IP Address
---------------------
In vmware go to :menuselection:`Edit --> Virtual Network Editor`. Set vmnet8 to NAT, tick both :guilabel:`Use local DHCP service to distribute IP addresses to VMs` and :guilabel:`Connect a host virtual adapter (vmnet8) to this network`. Set subnet IP to ``10.0.0.0``. The changes you made are saved to ``/etc/vmware/vmnet8/dhcpd/dhcpd.conf``. Edit this file and append::

    host tsvm {
        hardware ethernet 00:50:56:00:13:37;
        fixed-address 10.0.0.23;
    }

Now restart vmware networking services::

    /etc/init.d/vmware restart

From http://www.vmware.com/support/ws55/doc/ws_net_advanced_ipaddress.html and http://www.stereoplex.com/two-voices/vmware-fusion-guests-with-a-static-ip

Set Hostname on Host
--------------------
On host, edit::

    sudo vim /etc/hosts

and add::

    10.0.0.23 tsvm

IP Address in /etc/issue for Virtualbox
=======================================
::

    cat<<'EOF' > /etc/issue.template
    Ubuntu 12.04.1 LTS \n \l
    username: root
    password: toor
    ip address: IP_ADDRESS
    EOF

    cp /etc/rc.local /var/backup/
    cat<<'EOF' > /etc/rc.local
    ip_address=`ifconfig eth0 | awk '/inet addr/ {print $2}' | cut -f2 -d:`
    sed -e "s/IP_ADDRESS/$ip_address/" /etc/issue.template > /etc/issue
    exit 0
    EOF

