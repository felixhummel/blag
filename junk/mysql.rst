*****
MySQL
*****

Dev User
========
::

    CREATE USER '{{USERNAME}}'@'localhost' IDENTIFIED BY '{{PASSWORD}}';
    GRANT ALL PRIVILEGES ON `{{DBNAME}}` . * TO '{{USERNAME}}'@'localhost';

MySQL on Ramdisk
================
Install::

    mkdir -p /dev/shm/mysql/data
    cd /dev/shm/mysql

    mysql_install_db --datadir=/dev/shm/mysql/data

    mysqladmin -S /dev/shm/mysql/socket --port=9002 -u root password toor

defaults.conf::

    [mysqld]
    user      = felix
    socket    = /dev/shm/mysql/socket
    port      = 9002
    basedir   = /usr
    datadir   = /dev/shm/mysql/data
    tmpdir    = /dev/shm/mysql/tmp
    skip-external-locking

    bind-address    = 0.0.0.0

    key_buffer    = 16M
    max_allowed_packet  = 16M
    thread_stack    = 192K
    thread_cache_size       = 8

    myisam-recover         = BACKUP

    thread_concurrency     = 6

    query_cache_limit = 1M
    query_cache_size = 16M

    #general_log_file        = /var/log/mysql/mysql.log
    #general_log             = 1
    log_error                = /dev/shm/mysql/error.log

    log_slow_queries  = /dev/shm/mysql/mysql-slow.log
    long_query_time = 1
    #log-queries-not-using-indexes

    [isamchk]
    key_buffer    = 16M

start server::

    mysqld --defaults-file=/dev/shm/mysql/defaults.conf

client::

    mysql --socket=/dev/shm/mysql/socket --port=9002 -u root -p
