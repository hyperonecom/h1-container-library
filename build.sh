#!/bin/sh
set -eux
docker pull h1cr.io/website/alpine-shell:latest || echo 'Fail to pull h1cr.io/website/alpine-shell:latest'
docker build --cache-from h1cr.io/website/alpine-shell:latest -t h1cr.io/website/alpine-shell:latest alpine-shell/latest
docker pull h1cr.io/website/debian-shell:latest || echo 'Fail to pull h1cr.io/website/debian-shell:latest'
docker build --cache-from h1cr.io/website/debian-shell:latest -t h1cr.io/website/debian-shell:latest debian-shell/latest
docker pull h1cr.io/website/nginx-static:latest || echo 'Fail to pull h1cr.io/website/nginx-static:latest'
docker build --cache-from h1cr.io/website/nginx-static:latest -t h1cr.io/website/nginx-static:latest nginx-static/latest
docker pull h1cr.io/website/node:10 || echo 'Fail to pull h1cr.io/website/node:10'
docker build --cache-from h1cr.io/website/node:10 -t h1cr.io/website/node:10 node/10
docker pull h1cr.io/website/node:11 || echo 'Fail to pull h1cr.io/website/node:11'
docker build --cache-from h1cr.io/website/node:11 -t h1cr.io/website/node:11 node/11
docker pull h1cr.io/website/node:12 || echo 'Fail to pull h1cr.io/website/node:12'
docker build --cache-from h1cr.io/website/node:12 -t h1cr.io/website/node:12 node/12
docker pull h1cr.io/website/php-apache:5.6 || echo 'Fail to pull h1cr.io/website/php-apache:5.6'
docker build --cache-from h1cr.io/website/php-apache:5.6 -t h1cr.io/website/php-apache:5.6 php-apache/5.6
docker pull h1cr.io/website/php-apache:7.2 || echo 'Fail to pull h1cr.io/website/php-apache:7.2'
docker build --cache-from h1cr.io/website/php-apache:7.2 -t h1cr.io/website/php-apache:7.2 php-apache/7.2
docker pull h1cr.io/website/php-apache:7.3 || echo 'Fail to pull h1cr.io/website/php-apache:7.3'
docker build --cache-from h1cr.io/website/php-apache:7.3 -t h1cr.io/website/php-apache:7.3 php-apache/7.3
docker pull h1cr.io/website/php-apache-shell:5.6 || echo 'Fail to pull h1cr.io/website/php-apache-shell:5.6'
docker build --cache-from h1cr.io/website/php-apache-shell:5.6 -t h1cr.io/website/php-apache-shell:5.6 php-apache-shell/5.6
docker pull h1cr.io/website/php-apache-shell:7.2 || echo 'Fail to pull h1cr.io/website/php-apache-shell:7.2'
docker build --cache-from h1cr.io/website/php-apache-shell:7.2 -t h1cr.io/website/php-apache-shell:7.2 php-apache-shell/7.2
docker pull h1cr.io/website/php-apache-shell:7.3 || echo 'Fail to pull h1cr.io/website/php-apache-shell:7.3'
docker build --cache-from h1cr.io/website/php-apache-shell:7.3 -t h1cr.io/website/php-apache-shell:7.3 php-apache-shell/7.3
docker pull h1cr.io/website/python-passenger:3.7 || echo 'Fail to pull h1cr.io/website/python-passenger:3.7'
docker build --cache-from h1cr.io/website/python-passenger:3.7 -t h1cr.io/website/python-passenger:3.7 python-passenger/3.7