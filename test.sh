#!/bin/sh
set -eux
IMAGE="h1cr.io/website/alpine-shell:latest" bats alpine-shell/test/*
IMAGE="h1cr.io/website/debian-shell:latest" bats debian-shell/test/*
IMAGE="h1cr.io/website/nginx-static:latest" bats nginx-static/test/*
IMAGE="h1cr.io/website/php-apache:5.6" bats php-apache/test/*
IMAGE="h1cr.io/website/php-apache:7.2" bats php-apache/test/*
IMAGE="h1cr.io/website/php-apache:7.3" bats php-apache/test/*
IMAGE="h1cr.io/website/php-apache-shell:5.6" bats php-apache-shell/test/*
IMAGE="h1cr.io/website/php-apache-shell:7.2" bats php-apache-shell/test/*
IMAGE="h1cr.io/website/php-apache-shell:7.3" bats php-apache-shell/test/*