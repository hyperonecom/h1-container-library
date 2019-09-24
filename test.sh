#!/bin/sh
set -eux
IMAGE="h1cr.io/website/alpine-shell:latest" bats alpine-shell/test/*.bats
IMAGE="h1cr.io/website/debian-shell:latest" bats debian-shell/test/*.bats
IMAGE="h1cr.io/website/nginx-static:latest" bats nginx-static/test/*.bats
IMAGE="h1cr.io/website/node:10" bats node/test/*.bats
IMAGE="h1cr.io/website/node:11" bats node/test/*.bats
IMAGE="h1cr.io/website/node:12" bats node/test/*.bats
IMAGE="h1cr.io/website/php-apache:5.6" bats php-apache/test/*.bats
IMAGE="h1cr.io/website/php-apache:7.2" bats php-apache/test/*.bats
IMAGE="h1cr.io/website/php-apache:7.3" bats php-apache/test/*.bats
IMAGE="h1cr.io/website/php-apache-shell:5.6" bats php-apache-shell/test/*.bats
IMAGE="h1cr.io/website/php-apache-shell:7.2" bats php-apache-shell/test/*.bats
IMAGE="h1cr.io/website/php-apache-shell:7.3" bats php-apache-shell/test/*.bats