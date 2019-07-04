#!/bin/sh
set -eux
docker build -t h1cr.io/website/alpine-shell:latest alpine-shell/latest
docker build -t h1cr.io/website/debian-shell:latest debian-shell/latest
docker build -t h1cr.io/website/nginx-static:latest nginx-static/latest
docker build -t h1cr.io/website/node:10 node/10
docker build -t h1cr.io/website/node:11 node/11
docker build -t h1cr.io/website/node:12 node/12
docker build -t h1cr.io/website/php-apache:5.6 php-apache/5.6
docker build -t h1cr.io/website/php-apache:7.2 php-apache/7.2
docker build -t h1cr.io/website/php-apache:7.3 php-apache/7.3
docker build -t h1cr.io/website/php-apache-shell:5.6 php-apache-shell/5.6
docker build -t h1cr.io/website/php-apache-shell:7.2 php-apache-shell/7.2
docker build -t h1cr.io/website/php-apache-shell:7.3 php-apache-shell/7.3
docker build -t h1cr.io/website/python-passenger:3 python-passenger/3
docker build -t h1cr.io/website/python-passenger:3.7 python-passenger/3.7