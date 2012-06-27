******
Debian
******
Some notes from my Debian 5.0 (Lenny) server experiences.

Debian Locale
=============
Error::

    perl: warning: Falling back to the standard locale ("C").
    perl: warning: Setting locale failed.
    perl: warning: Please check that your locale settings:
            LANGUAGE = (unset),
            LC_ALL = (unset),
            LANG = "en_US.utf8"
        are supported and installed on your system.

Fix::

    sudo dpkg-reconfigure locales

Python 2.6 On Debian Lenny
==========================
http://www.saltycrane.com/blog/2008/10/installing-python-26-source-ubuntu-hardy/::

    sudo apt-get --no-install-recommends install build-essential\
                                                 libncursesw5-dev\
                                                 libreadline5-dev\
                                                 libssl-dev\
                                                 libgdbm-dev\
                                                 libbz2-dev\
                                                 libc6-dev\
                                                 libsqlite3-dev\
                                                 tk-dev
    wget http://www.python.org/ftp/python/2.6/Python-2.6.tgz
    tar xzf Python-2.6.tgz
    cd Python-2.6
    ./configure --prefix=/opt/python2.6
    make
    # ignore bsddb185 sunaudiodev
    sudo make install
