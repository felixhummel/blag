Bazaar VCS
==========

.. highlight:: bash

Effective Branching::

    cd /tmp
    mkdir bzr_experiments
    cd bzr_experiments/

    mkdir main
    cd main/
    bzr init .
    touch a
    bzr add
    bzr commit -m "added a"

    cd ..
    bzr branch main/ b1
    bzr branch main/ b2

    cd b1/
    touch b
    touch c
    bzr add
    bzr commit -m "added b and c"

    cd ../b2/
    touch d
    bzr add d
    bzr commit -m "added d"

    cd ../main/
    bzr merge ../b1/
    bzr commit -m "merged b1"
    bzr merge ../b2/
    bzr commit -m "merged b2"
