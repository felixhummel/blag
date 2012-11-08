PostgreSQL
==========
PostgreSQL 9.2 on Ubuntu 12.04 (`source <http://askubuntu.com/questions/186610/how-do-i-upgrade-to-postgres-9-2>`__)::

    sudo add-apt-repository ppa:pitti/postgresql 
    sudo apt-get update
    sudo apt-get install postgresql-9.2

Example database: http://www.commandprompt.com/ppbook/booktown.sql from http://wiki.postgresql.org/wiki/Sample_Databases

Permissions for local tcp: OK for PostgreSQL 9.2 (``local  all  postgres  md5``).

