#!/bin/sh
set -eux
docker push quay.io/hyperone/nginx-static:latest
docker push 5d08fcb2ca3915e50f7c2c55.registry.pl-waw-1.hyperone.cloud/hyperone/nginx-static:latest
docker push quay.io/hyperone/php-apache:5.6
docker push 5d08fcb2ca3915e50f7c2c55.registry.pl-waw-1.hyperone.cloud/hyperone/php-apache:5.6
docker push quay.io/hyperone/php-apache:7.2
docker push 5d08fcb2ca3915e50f7c2c55.registry.pl-waw-1.hyperone.cloud/hyperone/php-apache:7.2
docker push quay.io/hyperone/php-apache-shell:5.6
docker push 5d08fcb2ca3915e50f7c2c55.registry.pl-waw-1.hyperone.cloud/hyperone/php-apache-shell:5.6
docker push quay.io/hyperone/php-apache-shell:7.2
docker push 5d08fcb2ca3915e50f7c2c55.registry.pl-waw-1.hyperone.cloud/hyperone/php-apache-shell:7.2