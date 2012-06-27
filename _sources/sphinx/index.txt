******
Sphinx
******
.. toctree::

    cheatsheet

Built with Sphinx_, a small tutorial about Sphinx_.

.. _Sphinx: http://sphinx.pocoo.org/

What?
=====
::

    +--------+
    |   rst  |+        +----------+
    |  Files ||  ===>  |  Sphinx  |  ===>  HTML/PDF
    +--------+|        +----------+
     +--------+


Installation
============
::

    sudo pip install sphinx

Installing the development version of Sphinx is straight forward too.

.. code-block:: bash

    sudo easy-install jinja  # <-- templating engine
    wajig install mercurial  # <-- the version control system, sphinx developers use
    checkouts=$HOME/checkouts  # <-- where we'll keep the checkout
    mkdir -p $checkouts
    cd $checkouts
    hg clone http://bitbucket.org/birkenfeld/sphinx/
    cd sphinx
    sudo python setup.py install


Some resources
==============
- `Sphinx documentation <http://sphinx.pocoo.org/contents.html>`__
- `here <http://scienceoss.com/use-sphinx-for-documentation/>`__ I got started (actually it was `here <http://docs.python.org/>`__ at the bottom)
- `Sphinx Templates <http://www.proven-corporation.com/2008/03/27/sphinx-templates/>`_

See also:

