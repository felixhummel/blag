Virtualenv Upstart Instead of Init.d Scripts
============================================
This approach is even simpler than :doc:`venv_initd`.

Let's assume you have a user ``trac`` with group ``trac`` living in ``/home/trac`` which contains a Virtualenv. To run Trac you would issue the following commands::

    su - trac
    pwd
    # /home/trac
    source bin/activate
    tracd --port=8000 --hostname=0.0.0.0 --env-parent-dir=/home/trac/envs

To make this an Upstart service, create a file called ``/etc/init/trac.conf`` with the following contents::

    description "Trac daemon"

    start on runlevel [2345]
    stop on runlevel [!2345]

    setuid trac
    setgid git

    exec /home/trac/bin/tracd --port=8000 --hostname=0.0.0.0 --env-parent-dir=/home/trac/envs

Now start trac::

    service trac start

By using the full path ``/home/trac/bin/tracd`` virtualenv gets activated automatically. Check ``head -n 1 /home/trac/bin/tracd`` if you do not believe me.

The `setgid`_ line tells Upstart: "In addition to your main group (trac) use the group git too."

Another interesting option is `respawn`_. On death: revive.

.. _respawn: http://upstart.ubuntu.com/cookbook/#respawn
.. _setgid: http://upstart.ubuntu.com/cookbook/#setgid

