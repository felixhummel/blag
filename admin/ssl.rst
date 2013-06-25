***
SSL
***
StartSSL
========

Prereq::

    cd ~/startssl
    wget http://www.startssl.com/certs/sub.class1.server.ca.pem
    wget http://www.startssl.com/certs/ca.pem

    ssh SERVER mkdir /home/nginx/conf/certs

each cert, https://www.startssl.com/ > Control Panel > Certificates Wizard > Web Server Cert::

    vim DOMAIN_NAME/key
    openssl rsa -in DOMAIN_NAME/key -out DOMAIN_NAME/key
    vim DOMAIN_NAME/cert
    cat DOMAIN_NAME/cert sub.class1.server.ca.pem ca.pem > DOMAIN_NAME/chain
    ssh SERVER mkdir /home/nginx/conf/certs/DOMAIN_NAME
    scp DOMAIN_NAME/key DOMAIN_NAME/chain SERVER:/home/nginx/conf/certs/DOMAIN_NAME
    
Chain: http://blog.dembowski.net/2010/02/25/startssl-and-nginx/

Self-Signed (for development)
=============================
Mission:

- create self signed certificate for ``locutus.lan``
- use it in nginx
- import it for wget, chromium and firefox

Servername could also be fqdn, e.g. ``example.org`` or wildcard, e.g. ``'*.example.org'``. Remember to escape the asterisk!

::

    # as root
    servername=locutus.lan
    prefix=/etc/nginx/certs
    mkdir -p $prefix/$servername
    keyfile_path=$prefix/$servername/key
    signing_request_path=$prefix/$servername/csr
    cert_path=$prefix/$servername/crt

    openssl genrsa -out $keyfile_path 1024
    openssl req -new\
        -key $keyfile_path\
        -out $signing_request_path\
        -subj "/CN=$servername"

    openssl x509\
        -in $signing_request_path\
        -out $cert_path\
        -req -signkey $keyfile_path\
        -days 65500
    # let's see those files
    echo $prefix/$servername && ls $prefix/$servername

Use it in nginx by applying the following config::

    server {
        listen 443 ssl;
        server_name  localhost;

        ssl_certificate /etc/nginx/certs/localhost/crt;
        ssl_certificate_key /etc/nginx/certs/localhost/key;

        location / {
            auth_basic "myrealm";
            auth_basic_user_file /etc/nginx/auth/deimuddi;
            root   /srv/locutus.local;
            index  index.html index.htm;
        }
    }

Import for wget::

    cp /etc/nginx/certs/locutus.lan/crt /usr/lib/ssl/certs/locutus.lan.pem
    cd /usr/lib/ssl/certs
    ln -s locutus.lan.pem $(openssl x509 -noout -hash -in locutus.lan.pem).0
    # test it:
    wget https://locutus.lan/


Import for chromium (restart chromium afterwards)::

    nssdb_dir=$(sql:$HOME/.pki/nssdb)
    certutil -d $nssdb_dir -A -t "CT,C,C" -n locutus.lan -i /etc/nginx/certs/locutus.lan/crt

For firefox (every profile has an nssdb, restart firefox afterwards).
Note that there is no ``sql:``-prefix on the db path::

    for nssdb_dir in $(find  ~/.mozilla* -name "cert8.db" | xargs dirname); do
        certutil -d $nssdb_dir -A -t "P,p,p" -n locutus.lan -i /etc/nginx/certs/locutus.lan/crt
    done

.. note:: Tried the same for ``localhost``. Does not work.

