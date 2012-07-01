Salt Configuration Management
=============================
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

Links
-----
- http://saltstack.org/
- first look https://groups.google.com/forum/#!topic/salt-users/tfCu_dK10ZE
- salt-call http://salt.readthedocs.org/en/latest/topics/troubleshooting/index.html?highlight=debug#using-salt-call

