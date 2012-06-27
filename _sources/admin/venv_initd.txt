VirtualEnv Init.d Scripts the Easy Way
======================================
... at least, that's the way I build them. Take `RhodeCode <http://bitbucket.org/marcinkuzminski/rhodecode/src>`__ as an example.

1. ``sudo adduser --no-create-home --disabled-login rhodecode`` - create underprivileged user (no home dir, no shell)
2. Create ``/srv/rhodecode/start.sh`` with the following contents::

    #!/bin/bash
    # run this as the rhodecode user!

    WDIR=/srv/rhodecode
    VIRTUALENV_DIR=/opt/rhodecode-venv

    source $VIRTUALENV_DIR/bin/activate

    cd $WDIR
    paster serve production.ini 1> debug.log 2> error.log

3. Create ``/etc/init.d/rhodecode`` containing::


    #!/bin/sh
    # Start/stop rhodecode

    PIDFILE=/var/run/rhodecode.pid

    . /lib/lsb/init-functions

    NAME=rhodecode
    RUN_AS=`id -u rhodecode`
    CMD=/srv/rhodecode/start.sh
    OPTS=

    do_start() {
        start-stop-daemon --start --background --user $RUN_AS --pidfile $PIDFILE --chuid $RUN_AS --startas $CMD -- $OPTS
    }

    do_stop() {
        start-stop-daemon --stop --user $RUN_AS
    }

    case "$1" in
    start)
        log_action_msg "Starting $NAME"
        do_start
            ;;
    stop)                                                                                                                                                          
        log_action_msg "Stopping $NAME"                                                                                                                            
        do_stop                                                                                                                                                    
        ;;                                                                                                                                                         
    restart)                                                                                                                                                       
        log_action_msg "Restarting $NAME"
        do_stop
        do_start
        ;;
    *)
        log_action_msg "Usage: /etc/init.d/rhodecode {start|stop|restart}"
        exit 2
        ;;
    esac
    exit 0

4. Run ``/etc/init.d/rhodecode``.

.. note:: ``stop`` kills all processes for the associated user. Don't try this at home if you don't know what you are doing!

