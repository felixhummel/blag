Gitolite
========
Page: http://sitaramc.github.com/gitolite/. This is for version 3.

Git must be installed. See https://github.com/felixhummel/configs#installing-git on how to build latest git stable.

Boxes:

- think (local notebook)
- serv (remote server, fresh ubuntu 12.04)

Add serv to SSH config::

    cat <<'EOF' >> ~/.ssh/config
    Host serv
      Hostname SOME_IP_OR_DOMAIN_NAME
      User root
    EOF 

Copy public key for admin account to server. On think::

    scp ~/.ssh/id_rsa.pub serv:/tmp/felix.pub

Now ssh to server::

    ssh serv

Install gitolite::

    adduser --system --shell /bin/sh --gecos 'git version control' --group --disabled-password --home /home/git git
    su - git
    mkdir -p $HOME/bin
    export PATH=$PATH:$HOME/bin
    gitolite/install -ln
    gitolite setup -pk /tmp/felix.pub
    exit

On think again::

    git clone git@serv:gitolite-admin

