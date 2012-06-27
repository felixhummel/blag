******
Python
******
.. toctree::
    :glob:

    *

New Script Skeleton
===================
.. literalinclude:: skeleton.py

This is all you need to make an executable python module_ that defines
`UTF-8 <http://en.wikipedia.org/wiki/Utf-8>`_ as it's default encoding
for both vim and python. Download it :download:`here <skeleton.py>`.

.. _module: http://docs.python.org/tutorial/modules.html

Packages
========
... are just directories with an ``__init__.py`` file in them:

.. literalinclude:: __init__.py

Ipython
=======
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
