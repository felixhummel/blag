Puppet on Ubuntu 12.04 LTS
==========================
Master: ``locutus.local`` and client: ``ubuntu1204.local``

DNS is set up, so those work::

    locutus $ ping ubuntu1204
    ubuntu1204 $ ping locutus

Puppet Agent
------------
Agent: As root or ``sudo bash``::

    wget http://apt.puppetlabs.com/puppetlabs-release_1.0-3_all.deb
    dpkg -i puppetlabs-release_1.0-3_all.deb
    apt-get update && apt-get -y install puppet
    sed -i -e 's/START=no/START=yes/' /etc/default/puppet
    service puppet start


Agent: Apply ntp manifest::

    cat <<'EOF'>ntp.pp
    class ntp {
      package { "ntp": 
        ensure => installed 
      }

      service { "ntp":
        ensure => running,
      }
    }

    class {'ntp': }
    EOF

    puppet apply ntp.pp

Agent: Configure puppet::

    mv /etc/puppet/puppet.conf /etc/puppet/puppet.conf.bak
    cat <<'EOF'> /etc/puppet/puppet.conf
    [main]
      logdir=/var/log/puppet
      vardir=/var/lib/puppet
      ssldir=/var/lib/puppet/ssl
      rundir=/var/run/puppet
      factpath=$vardir/lib/facter
      templatedir=$confdir/templates

    [master]
      # These are needed when the puppetmaster is run by passenger
      # and can safely be removed if webrick is used.
      ssl_client_header = SSL_CLIENT_S_DN
      ssl_client_verify_header = SSL_CLIENT_VERIFY

    [agent]
      certname = ubuntu1204.local
      server = locutus.local
      report = true
      classfile = $vardir/classes.txt
      localconfig = $vardir/localconfig
      graph = true
      pluginsync = true
    EOF

Agent: create certificate and try to connect to master::

    puppet agent --test

Master: sign certificate::

    sudo puppet cert list
    sudo puppet cert sign ubuntu1204.local

Restarting a Virtual Machine That Is Signed
-------------------------------------------
Fix date::

    service ntp stop
    ntpdate pool.ntp.org
    service ntp start
    puppet agent --test --debug

Further Reading
---------------
- http://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html#for-debian-and-ubuntu (ubuntu packages)
- http://docs.puppetlabs.com/guides/installation.html#post-install
- http://www.puppetcookbook.com/
- http://projects.puppetlabs.com/projects/1/wiki/Advanced_Puppet_Pattern
- http://docs.puppetlabs.com/guides/style_guide.html
- http://bitcube.co.uk/content/puppet-errors-explained


