#!/usr/bin/python
# vim: set fileencoding=utf-8 :

import sys
from os import walk, removedirs
"""
Deletes all directories that are either empty or have empty directories in them.

Another way to look at it: Deletes folder structure without touching the files.

See `os.walk`_ and `os.removedirs`_ in the python documentation.

.. _os.walk: http://docs.python.org/library/os.html#os.walk
.. _os.removedirs: http://docs.python.org/library/os.html#os.removedirs
"""

def delete_useless_dirs(root):
    count = 0
    for path, dirs, files in walk(root, topdown=False):
        empty = len(dirs) == 0 and len(files) == 0
        if empty and not path == '.':
            removedirs(path)
            count += 1
    return count

if __name__ == '__main__':
    try:
        root = sys.argv[1]
        print "deleted %d directories"%delete_useless_dirs(root)
    except IndexError:
        print 'Usage: %s <root path>'%sys.argv[0]
        sys.exit(1)
