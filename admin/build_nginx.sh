#!/usr/bin/env bash
set -x

export NGINX_VERSION=1.2.1
export PREFIX=/opt/nginx

curl -O http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz || exit 1
git clone https://github.com/yaoweibin/nginx_tcp_proxy_module.git
tar -xvzf nginx-$NGINX_VERSION.tar.gz
cd nginx-$NGINX_VERSION
patch -p1 < ../nginx_tcp_proxy_module/tcp.patch
#./configure --add-module=../nginx_tcp_proxy_module/
./configure --prefix=$PREFIX --user=nginx --group=nginx --with-http_ssl_module --with-http_geoip_module --with-http_flv_module --add-module=../nginx_tcp_proxy_module/
sudo make && make install

