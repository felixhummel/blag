neatx
======
Basically it's a GNU screen with X server and suspend/resume.

Server install
--------------
It's all there::

    add-apt-repository ppa:freenx-team/ppa
    wajig update
    wajig install neatx-server

Client install
--------------
Download `here <http://www.nomachine.com/download-client-linux.php>`__ and::

    wajig install ./nxclient_3.4.0-7_i386.deb

Pitfalls
--------
To use suspend u need to have a window manager set. I like `ratpoison <http://ratpoison.antidesktop.net/>`__ as it's lightweight, all apps are fullscreen by default and there's no `Alt-Tab` shortcut, so whenever there will be an NX client for the N900, ratpoison makes switching windows easy (plus: alt-tab conflicts with my default window manager).

- switch windows with `C-t C-t`
- run command with `C-t !`
