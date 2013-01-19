Etherpad Lite with PostgreSQL
=============================
.. todo:: installation

Backup and Restore Database
---------------------------
::

    mkdir /var/backups/pad
    sudo -Hu postgres pg_dump pad > /var/backups/pad/`date +%F`.sql
    cp settings.json /var/backups/pad/

    # git pull or git clone - depends
    cp -r /home/pad/ /srv/pad
    cd /srv/pad
    git pull

    /root/devops/root/bin/postgres_create_user_and_db pad2
    chown -R pad:pad /srv/pad
    cd /srv/pad
    sudo -Hu pad npm install pg

    sudo -Hu postgres PGDATABASE=pad2 psql < /var/backups/pad/pad.sql

    vim settings.json  # user = pad2
    sudo -Hu pad bin/run.sh

sudo -Hu postgres psql::

    \c pad2
    alter table store owner to pad2;
    alter table v_pads owner to pad2;
    alter function public.ueberdb_insert_or_update(character varying, text) owner to pad2;

.. todo:: find better way to set owner - maybe do not export?

