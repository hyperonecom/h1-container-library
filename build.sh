#!/bin/sh
set -eux
docker build -t h1cr.io/website/alpine-shell:latest alpine-shell/latest
docker build -t h1cr.io/website/debian-shell:latest debian-shell/latest
docker build -t h1cr.io/website/nginx-static:latest nginx-static/latest
docker build -t h1cr.io/website/php-apache:5.6 php-apache/5.6
docker build -t h1cr.io/website/php-apache:7.2 php-apache/7.2
docker build -t h1cr.io/website/php-apache:7.3 php-apache/7.3
docker build -t h1cr.io/website/php-apache-shell:5.6 php-apache-shell/5.6
docker build -t h1cr.io/website/php-apache-shell:7.2 php-apache-shell/7.2
docker build -t h1cr.io/website/php-apache-shell:7.3 php-apache-shell/7.3