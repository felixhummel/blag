Puppet on Ubuntu 12.04 LTS
==========================
Master: ``locutus.local`` and client: ``ubuntu1204.local``

DNS is set up, so those work::

    locutus $ ping ubuntu1204
    ubuntu1204 $ pint locutus

Puppet Agent
------------
::

    wget http://apt.puppetlabs.com/puppetlabs-release_1.0-3_all.deb
    sudo dpkg -i puppetlabs-release_1.0-3_all.deb
    apt-get update && apt-get -y install puppet
    sed -i -e 's/START=no/START=yes/' /etc/default/puppet
    service puppet start


Configure Agent with ::

    [agent]
        certname = ubuntu1204.local
        server = locutus.local
        report = true
        classfile = $vardir/classes.txt
        localconfig = $vardir/localconfig
        graph = true
        pluginsync = true


Further Reading
---------------
- http://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html#for-debian-and-ubuntu (ubuntu packages)
- http://docs.puppetlabs.com/guides/installation.html#post-install
- http://docs.puppetlabs.com/guides/style_guide.html
