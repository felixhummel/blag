***************************************************************************
How to explore (and edit) a MySQL server's content conveniently in Eclipse.
***************************************************************************
Prerequisites
=============
1. mysql is running
2. mysql-server is localhost (if not, substitute ``localhost`` with ``<your-server-name>``)

Tested on Ubuntu 8.04, but should run everywhere with some modifications.

MySQL JDBC Connector
====================
.. highlight:: bash

This library serves as driver for the SQL Explorer::

	libPath=$HOME/lib
	cd /tmp
	wget ftp://sunsite.informatik.rwth-aachen.de/pub/mirror/www.mysql.com/Downloads/Connector-J/mysql-connector-java-5.1.7.tar.gz
	tar zxvf mysql-connector-java-5.1.7.tar.gz
	cp mysql-connector-java-5.1.7/mysql-connector-java-5.1.7-bin.jar $libPath

Homepage: http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.7.tar.gz/from/pick#mirrors

(There's a *No thanks, just take me to the downloads!* link on the bottom.)

SQL Explorer
============
- Update-Site: http://eclipsesql.sourceforge.net/
- Homepage: http://eclipsesql.sourceforge.net/

:menuselection:`Window --> Open Perspective --> Other --> SQL Explorer`

Create new Connection:

:menuselection:`Connection --> Create New Connection Profile` (first button)

- Name: give it a name (e.g. ``root@localhost``)
- Driver: Add/Edit Drivers
	- select MySQL > Edit
		- Extra Class Path > Add > $libPath/mysql-connector-java-5.1.7-bin.jar
		- List Drivers (``com.mysql.jdbc.Driver`` is fine)
		- OK
	- OK
- URL: ``jdbc:mysql://localhost/``
- everything else is self-explanatory
