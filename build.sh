#!/bin/sh
set -eux
docker build -t quay.io/hyperone/php-apache:7.2 php-apache/7.2
docker build -t quay.io/hyperone/php-apache:5.6 php-apache/5.6
docker build -t quay.io/hyperone/php-apache-shell:7.2 php-apache-shell/7.2
docker build -t quay.io/hyperone/php-apache-shell:5.6 php-apache-shell/5.6