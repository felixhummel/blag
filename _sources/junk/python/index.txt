Python
======
http://python.org/.

From Distutil's Setup.py to an Installable Egg
----------------------------------------------
"Edit the target package's ``setup.py`` and add ``from setuptools import setup`` such that it replaces the existing import of the setup function. Then run ``setup.py bdist_egg``." [#xx]_

Yeah: :mod:`delete_empty_directories`.

Always remember: Explicit is better than implicit!

What's that?::

    set(string.lowercase).difference(set(filter(lambda x: x in string.lowercase, [x[0] for x in filter(os.path.isdir, os.listdir(os.path.expanduser('~')))])))

.. rubric:: Footnotes

.. [#xx] http://peak.telecommunity.com/DevCenter/PythonEggs#building-eggs

