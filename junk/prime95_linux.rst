Prime 95 on Linux
=================
::

    wget http://mersenneforum.org/gimps/p95v277.linux64.tar.gz
    aunpack p95v277.linux64.tar.gz
    rm p95v277.linux64.tar.gz
    cd p95v277.linux64/
    ./mprime -t


get and configure sensors::

    wajig install lm-sensors
    sensors-detect

watch em BURNNN!!!

::

    htop
    watch 'sensors | grep Core'


