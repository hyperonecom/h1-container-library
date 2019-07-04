#!/bin/sh
set -eux
IMAGE="quay.io/hyperone/nginx-static:latest" bats nginx-static/test/*
IMAGE="quay.io/hyperone/php-apache:5.6" bats php-apache/test/*
IMAGE="quay.io/hyperone/php-apache:7.2" bats php-apache/test/*
IMAGE="quay.io/hyperone/php-apache-shell:5.6" bats php-apache-shell/test/*
IMAGE="quay.io/hyperone/php-apache-shell:7.2" bats php-apache-shell/test/*