SSL
===
StartSSL
--------

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
