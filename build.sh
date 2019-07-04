#!/bin/sh
set -eux
docker build -t quay.io/hyperone/nginx-static:latest nginx-static/latest
docker build -t 5d08fcb2ca3915e50f7c2c55.registry.pl-waw-1.hyperone.cloud/hyperone/nginx-static:latest nginx-static/latest
docker build -t quay.io/hyperone/php-apache:5.6 php-apache/5.6
docker build -t 5d08fcb2ca3915e50f7c2c55.registry.pl-waw-1.hyperone.cloud/hyperone/php-apache:5.6 php-apache/5.6
docker build -t quay.io/hyperone/php-apache:7.2 php-apache/7.2
docker build -t 5d08fcb2ca3915e50f7c2c55.registry.pl-waw-1.hyperone.cloud/hyperone/php-apache:7.2 php-apache/7.2
docker build -t quay.io/hyperone/php-apache-shell:5.6 php-apache-shell/5.6
docker build -t 5d08fcb2ca3915e50f7c2c55.registry.pl-waw-1.hyperone.cloud/hyperone/php-apache-shell:5.6 php-apache-shell/5.6
docker build -t quay.io/hyperone/php-apache-shell:7.2 php-apache-shell/7.2
docker build -t 5d08fcb2ca3915e50f7c2c55.registry.pl-waw-1.hyperone.cloud/hyperone/php-apache-shell:7.2 php-apache-shell/7.2