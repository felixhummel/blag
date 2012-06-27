******
Apache
******
Some notes about stuff I kept googling.

SSL
===
.. highlight:: bash

Need key and cert? As root::

    servername=example.org  # <-- this is a usage example ;)
    servername=
    prefix=/srv/certs
    mkdir -p $prefix
    keyfile_path=$prefix/$servername.key
    signing_request_path=$prefix/$servername.csr
    cert_path=$prefix/$servername.crt
    # create the private key
    openssl genrsa -out $keyfile_path 1024
    # create a signing request (if you don't care, press enter 9 times)
    # for wildcard certificates (e.g. *.domain.com), set Common Name accordingly
    openssl req -new\
        -key $keyfile_path\
        -out $signing_request_path
    # create a self-signed certificate
    openssl x509\
        -in $signing_request_path\
        -out $cert_path\
        -req -signkey $keyfile_path\
        -days 65500
    # let's see those files
    echo $prefix && ls $prefix

Example config::

    document_root=
    basic_auth_file=
    echo "<VirtualHost $servername:443>
        ServerName $servername
        DocumentRoot $document_root

        SSLEngine on
        SSLCertificateKeyFile $keyfile_path
        SSLCertificateFile $cert_path

        <Directory \"$document_root\">
            Options Indexes FollowSymLinks
            AllowOverride none
            Order allow,deny
            Allow from all
            AuthType Basic
            AuthName $(basename $document_root)
            AuthUserFile $basic_auth_file
        </Directory>

    </VirtualHost>"

Sources
-------
http://www.crazysquirrel.com/computing/debian/apache-mod_ssl.jspx
