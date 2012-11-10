Ipython
=======

Benefits
--------
Is "An Enhanced Interactive Python". Install it with (see :ref:`wajig`)::

    wajig install ipython

It has many great features, but these are the best:

1. Tab-Completion.
2. "Dynamic object information"
    
    try ``import os`` and then ``os?`` for basic info and ``os??`` for the source

3. type ``%edit file.py`` to edit and run ``file.py``

    for this to work, you should set the ``EDITOR``-variable to your favorite editor, e.g.::

        echo 'export EDITOR=/usr/bin/vim' >> $HOME/.bashrc
        source $HOME/.bashrc

4. Scientists love it ;)

Make IPython aware of virtualenvs
---------------------------------
Tested with IPython 0.12 on Ubuntu 12.04 (precise).

Create ipython profile::

    ipython profile create

Modify `/usr/bin/ipython` to look like this (:download:`download <ipython>`):

.. literalinclude:: ipython

Copy :download:`virtualenv.py` to `~/.config/ipython/profile_default/startup/`.

Enjoy!

Sources:

- http://isbullsh.it/2012/04/Embed-ipython-in-virtualenv/
- http://archlinux.me/w0ng/2012/04/09/make-ipython-recognise-virtualenv/
- http://stackoverflow.com/questions/11573844/ipython-import-failure-and-python-sys-path-in-general
- http://stackoverflow.com/a/8032599/241240 ("startup folder in profile directories")

