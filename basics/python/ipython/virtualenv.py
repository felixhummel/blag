# Modified for Python 3 (https://gist.github.com/1759781)
import sys
from os import environ
from os.path import join, sep

if 'VIRTUAL_ENV' in environ:
    # rollback hack in /usr/bin/ipython
    # remove all occurences of these entries (just to be sure)
    # this would obviously break if we had a venv in one of these dirs, but who in
    # the right state of mind would do that?
    sys.path = filter(lambda x: x != '/usr/lib/python2.7/dist-packages', sys.path)
    sys.path = filter(lambda x: x != '/usr/lib/pymodules/python2.7', sys.path)

    virtual_env_dir = environ['VIRTUAL_ENV']
    activate_this = join(virtual_env_dir, "bin", "activate_this.py")
    exec(compile(open(activate_this).read(), activate_this, 'exec'),
         dict(__file__=activate_this))
    virtual_env_name = virtual_env_dir.split(sep)[-1]
    message = '\nFound virtualenv "{0}" ({1})]'.format(virtual_env_name,
                                               virtual_env_dir)
    print(message)
    del virtual_env_dir, activate_this, virtual_env_name, message
del sys, environ, join, sep

