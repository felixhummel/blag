PostgreSQL
==========
.. highlight:: bash

PostgreSQL 9.2 on Ubuntu 12.04 (`source <http://askubuntu.com/questions/186610/how-do-i-upgrade-to-postgres-9-2>`__)::

    sudo add-apt-repository ppa:pitti/postgresql 
    sudo apt-get update
    sudo apt-get install postgresql-9.2

Allow connections via socket and MD5 password
---------------------------------------------
sudo vim /etc/postgresql/9.2/main/pg_hba.conf::

    # md5-based auth instead of peer auth
    #local   all             all                                     peer
    local   all             all                                     md5

Example database
----------------
Connect as user *postgres* (admin)::

    sudo -u postgres psql

Create user and database:

.. code-block:: sql

    CREATE USER sample WITH PASSWORD 'sample';
    CREATE DATABASE users WITH OWNER sample;
    GRANT ALL PRIVILEGES ON DATABASE users TO sample;

.. todo:: publish repo with example db, link here

Clean up:

.. code-block:: sql

    DROP DATABASE users;
    DROP USER sample;

Links
-----
- examples (outdated but cool) http://www.commandprompt.com/ppbook/booktown.sql
- Sequences http://www.neilconway.org/docs/sequences/
- environment variables http://www.postgresql.org/docs/9.2/static/libpq-envars.html
- psql script debug flags http://archives.postgresql.org/pgsql-hackers/2010-06/msg00350.php
- limit and total: http://stackoverflow.com/questions/156114/best-way-to-get-result-count-before-limit-was-applied-in-php-postgres
    - problem with many (> 500k) rows
    - maybe adapt the following strategy (to deliver query times < 0.5 sec):
        - if count(*) < 100000: select via count(*) over()
        - else: return count from table "counts (table_name, count, date)"
        - background job - nightly or parallel (maybe even on RO-replica)
- timing queries --> ``\timing``: http://dba.stackexchange.com/questions/3148/how-can-i-time-sql-queries-using-psql


