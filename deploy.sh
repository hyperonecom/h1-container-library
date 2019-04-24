#!/bin/sh
set -eux
docker push quay.io/hyperone/php-apache:7.2
docker push quay.io/hyperone/php-apache:5.6
docker push quay.io/hyperone/php-apache-shell:7.2
docker push quay.io/hyperone/php-apache-shell:5.6