Nginx + Socket.io = Secure Websockets via SSL
=============================================
- nginx + socket.io example https://chrislea.com/2013/02/23/proxying-websockets-with-nginx/
- great secure web socket proxy post http://www.exratione.com/2013/06/websockets-over-ssl-with-nodejs-and-nginx/
- maybe troubleshooting? http://arthur-notes.blogspot.de/2013/01/setting-up-nginx-for-socketio.html

hostname is ``locutus.lan``

generate ssl certs and add to clients (see :doc:`/admin/ssl`).

install node::

    mkdir -p ~/checkouts/node
    cd ~/checkouts/node
    git clone git://github.com/joyent/node.git
    cd node
    git checkout v0.10.12
    ./configure
    make
    sudo make install

fetch example chat app::

    cd ~/checkouts/node
    git clone https://github.com/mmukhin/psitsmike_example_1.git
    cd psitsmike_example_1
    npm install -d
    node app.js

Check http://localhost:8080/ to see that it worked. Kill it. Set correct socket.io endpoint::

    git apply <<'ENDOFPATCH'
    diff --git a/index.html b/index.html
    index a8a54c9..e2960c6 100644
    --- a/index.html
    +++ b/index.html
    @@ -1,7 +1,7 @@
     <script src="/socket.io/socket.io.js"></script>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script>
     <script>
    -  var socket = io.connect('http://localhost:8080');
    +  var socket = io.connect('https://locutus.lan');

       // on connection to server, ask for user's name with an anonymous callback
       socket.on('connect', function(){
    ENDOFPATCH

Install and configure nginx (as root)::

    add-apt-repository --yes ppa:nginx/stable &&
        apt-get update &&
        apt-get install --yes nginx

    rm /etc/nginx/sites-enabled/default

    cat <<'EOF' > /etc/nginx/sites-available/locutus.lan
    upstream node {
      # Directs to the process with least number of connections.
      least_conn;
      server 127.0.0.1:8080;
    }

    server {
      listen 80;
      listen 443 ssl;
      server_name  locutus.lan;

      ssl_certificate /etc/nginx/certs/locutus.lan/crt;
      ssl_certificate_key /etc/nginx/certs/locutus.lan/key;

      # Redirect all non-SSL traffic to SSL.
      if ($ssl_protocol = "") {
        rewrite ^ https://$host$request_uri? permanent;
      }

      location / {
        proxy_pass http://node;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection upgrade;
        proxy_set_header Host $host;
      }

    }
    EOF

    ln -s /etc/nginx/sites-available/locutus.lan /etc/nginx/sites-enabled/locutus.lan

    service nginx configtest
    service nginx restart

