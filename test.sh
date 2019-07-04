#!/bin/sh
set -eux
IMAGE="5d08fcb2ca3915e50f7c2c55.registry.pl-waw-1.hyperone.cloud/nginx-static:latest" bats nginx-static/test/*
IMAGE="5d08fcb2ca3915e50f7c2c55.registry.pl-waw-1.hyperone.cloud/php-apache:5.6" bats php-apache/test/*
IMAGE="5d08fcb2ca3915e50f7c2c55.registry.pl-waw-1.hyperone.cloud/php-apache:7.2" bats php-apache/test/*
IMAGE="5d08fcb2ca3915e50f7c2c55.registry.pl-waw-1.hyperone.cloud/php-apache-shell:5.6" bats php-apache-shell/test/*
IMAGE="5d08fcb2ca3915e50f7c2c55.registry.pl-waw-1.hyperone.cloud/php-apache-shell:7.2" bats php-apache-shell/test/*