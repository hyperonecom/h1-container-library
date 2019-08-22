#!/bin/sh
set -eux
docker push h1cr.io/website/alpine-shell:latest
docker push h1cr.io/website/debian-shell:latest
docker push h1cr.io/website/nginx-static:latest
docker push h1cr.io/website/php-apache:5.6
docker push h1cr.io/website/php-apache:7.2
docker push h1cr.io/website/php-apache:7.3
docker push h1cr.io/website/php-apache-shell:5.6
docker push h1cr.io/website/php-apache-shell:7.2
docker push h1cr.io/website/php-apache-shell:7.3