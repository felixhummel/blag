**********
Networking
**********
.. contents::

SSH
===
- simple :ref:`installation`
- remote shell
- file transfer
- secure
- `standard <http://tools.ietf.org/html/rfc4252>`_
- http://en.wikipedia.org/wiki/Secure_Shell

.. _installation:

Installation
------------
The client is already installed. To install the server::

    wajig install openssh-server

Usage
-----
Connect to host ``notebook``::

    ssh notebook

File Transfer
-------------
In :ref:`Krusader`'s/Dolphin's/<your-graphical-filemanager-name-here> address bar, type::

    sftp://notebook

To merely copy a file::

    scp notebook:myfile .  # copies /home/me/myfile on notebook to current working directory
    scp notebook:/etc/passwd .  # copies /etc/passwd on notebook to current working directory

Authentication
--------------
Either with username/password or through public key encryption. The latter is very easy to setup and even lets you skip the password prompt (if you choose an empty password).

Assumption: working on *desktop*, connecting to *notebook*::

    ssh-keygen  # only if you haven't done it already
                # leave default
    ssh-copy-id notebook
    ssh notebook

If you chose an empty password and *desktop* gets compromised, then *notebook* will be too.

Mounting SSH
------------
Prerequisites::

    sshfs

Mounting::

    sshfs remotehost: /local/dir/

Unmounting::

    fusermount -u /local/dir/

See `this Ubuntu wiki page <https://help.ubuntu.com/community/SSHFS>`__ for more details.

List Open Ports
===============
... excluding sockets::

    netstat --numeric-hosts --protocol=inet

We use :option:`--numeric-hosts` because dns lookups can be quite slow.
