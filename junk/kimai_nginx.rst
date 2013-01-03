Kimai Nginx Install
===================
user www-data to nginx::

    vim /etc/php5/fpm/pool.d/www.conf
    service php5-fpm restart

nginx config::

    server {
      listen       80;
      server_name  BLUBB;

      #charset koi8-r;

      #access_log  logs/host.access.log  main;

      location / {
        root   BLAH;
        index  index.html index.htm;
      }
      #error_page  404              /404.html;

      # redirect server error pages to the static page /50x.html
      #
      error_page   500 502 503 504  /50x.html;
      location = /50x.html {
        root   html;
      }

      # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
      #
      location ~ \.php$ {
        root           BLAH;
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME    $document_root$fastcgi_script_name;
        include        fastcgi_params;
      }
    }

DB::

    CREATE USER 'kimai'@'localhost' IDENTIFIED BY 'kimai';
    GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER ON `kimai`.* TO 'kimai'@'localhost';
    CREATE DATABASE kimai;

post::

    cd kimai/
    rm -r installer/

