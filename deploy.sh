#!/bin/sh
docker pull quay.io/hyperone/php-apache:7.2 && echo true
docker build --pull -t quay.io/hyperone/php-apache:7.2 php-apache/7.2
docker pull quay.io/hyperone/php-apache:5.6 && echo true
docker build --pull -t quay.io/hyperone/php-apache:5.6 php-apache/5.6
docker pull quay.io/hyperone/php-apache-shell:7.2 && echo true
docker build --pull -t quay.io/hyperone/php-apache-shell:7.2 php-apache-shell/7.2
docker pull quay.io/hyperone/php-apache-shell:5.6 && echo true
docker build --pull -t quay.io/hyperone/php-apache-shell:5.6 php-apache-shell/5.6