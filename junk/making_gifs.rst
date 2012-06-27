Making Gifs
===========
``kdenlive`` to edit

crop::

    mplayer -vf cropdetect file.avi

to gif::

    mplayer -vf crop=528:432:96:72 -vo gif89a file.avi

generates ``out.gif``.
