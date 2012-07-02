Salt Configuration Management
=============================
Minion Install::

    sudo apt-get install -y python-software-properties
    sudo add-apt-repository -y ppa:saltstack/salt
    sudo apt-get update
    sudo apt-get install -y salt-minion

Master Install::

    sudo apt-get install python-software-properties
    sudo add-apt-repository ppa:saltstack/salt
    sudo apt-get update
    sudo apt-get install salt-master


Minion: Who is your master?

::

    sed -i.bak -e 's/#master: salt/master: locutus/' /etc/salt/minion
    service salt-minion restart

Master: Accept obedient minion::

    sudo salt-key -L
    sudo salt-key -a ubuntu1204

Master: Order your minion::

    sudo salt \* test.ping

Test run on minion::

    salt-call -l debug state.highstate

Workflow for remote execution modules::

    vim /srv/salt/_modules/foo.py
    sudo salt ubuntu1204 saltutil.sync_all
    sudo salt --text-out ubuntu1204 foo.bar
    # if this does not work. do it on the minion
    salt-call saltutil.sync_all; salt-call foo.bar
    # to reload, restart minion and master daemons

Notes
-----
- from bash to state
    1. try command: psql -t -c "select datname from pg_catalog.pg_database"
    2. create salt function: postgres.db_list
    3. repeat steps 1 and 2 for other stuff
    4. create salt state

Stupid Error Messages
---------------------
Whey I ran ``salt-call postgres.user_create trac password=trac login=true``, I got::

    got multiple values for keyword argument 'foo'

What it meant: You have forgotten to add the argument "login" to your user_create function.

Links
-----
- http://saltstack.org/
- first look https://groups.google.com/forum/#!topic/salt-users/tfCu_dK10ZE
- salt-call http://salt.readthedocs.org/en/latest/topics/troubleshooting/index.html?highlight=debug#using-salt-call

