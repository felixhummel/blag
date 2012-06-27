Best Apps Ever
==============
.. contents::

Unless stated otherwise installation of these applications is as easy as typing::

    wajig install <application-name-in-lowercase>

.. note::

    You need :ref:`wajig <wajig>` for this to work. You can install it with::

        sudo apt-get install wajig

.. _wajig:

Wajig (Package Management)
--------------------------
Wajig is a friendly front end to Debian's (and therefore also Ubuntu's) package system 
APT (the `Advanced Packaging Tool`_), dpkg, apt-cache, apt-search, ...

Motivation
^^^^^^^^^^
1. typing ``waji<TAB>`` feels right
2. getting all available subcommands with ``wajig <TAB><TAB>`` is just nice
3. tab-completion for package-names rocks, e.g. ``wajig install krus<TAB>`` :)

.. _Advanced Packaging Tool: http://www.debian.org/doc/manuals/apt-howto/ch1.en.html

Alternatives
^^^^^^^^^^^^
Commands like::

    wajig install <some-package>

can be substituted with::

    sudo apt-get install <some-package>

Note that ``waji<TAB> ins<TAB><SPACE> <package-name>`` takes 9 keystrokes while ``sud<TAB><SPACE> apt-g<TAB> i<TAB> <package-name>`` needs 13 keystrokes and contains a minus. ;)

If you love clicking around, there are also some `graphical apt-frontends <http://en.wikipedia.org/wiki/Advanced_Packaging_Tool#Front-ends>`__.

.. _krusader:

Krusader (File Manager)
-----------------------
If you ever used Norton Commander, Total Commander or any other twin panel file manager, then Krusader is for
you. It's the reason I switched from Gnome to KDE (besides great keyboard shortcut capabilities). Check out the `screenshots <http://www.krusader.org/screenshots.php>`__!

Yakuake (Quake Style Console)
-----------------------------
If you like Quake_'s Console, then you will love Yakuake. I wrote a skin_ that integrates nicely with dark (green on black) themes. Enjoy!

.. _Quake: http://www.idsoftware.com/games/quake/quake3-arena/
.. _skin: http://www.kde-look.org/content/show.php/Yakuake+Skin:+Green+on+Black?content=93601
