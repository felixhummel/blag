Git, Gitosis
============
Client
------
Copy pub key to serv::

    scp ~/.ssh/id_rsa.pub serv:felix@acer.pub

Server
------
Add Git user::

    adduser --system --shell /bin/sh --gecos 'git user' --group --disabled-password git


Initialize gitosis::

    sudo -H -u git gitosis-init < felix@acer.pub

Client
------
Clone gitosis-admin::

    git clone git@serv:gitosis-admin


