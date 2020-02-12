FROM chialab/php:7.4-apache
LABEL maintainer="HyperOne"
LABEL rbx.shell_image="h1cr.io/website/php-apache-shell:7.4"
ENV IMAGICK_VERSION="3.4.4"
COPY ./site.conf /etc/apache2/sites-available/000-default.conf
COPY ./ports.conf /etc/apache2/ports.conf
RUN sed -i 's@Directory /var/www/@Directory /data/public@g' /etc/apache2/conf-available/docker-php.conf /etc/apache2/apache2.conf
RUN apt-get update \
# Following command add 200 MB dependencies
&& apt-get install -y --no-install-recommends zlib1g-dev libcurl3-dev libpng-dev libmagickwand-dev locales \
&& rm -rf /var/lib/apt/lists/* \
&& pecl install imagick-"$IMAGICK_VERSION" \
&& docker-php-ext-enable imagick
RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen \
&& dpkg-reconfigure --frontend=noninteractive locales \
&& update-locale LANG=en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
COPY ./php.ini /usr/local/etc/php/php.ini
ENV PHP_INI_SCAN_DIR="/data/etc/php/conf.d/:/usr/local/etc/php/conf.d/"
RUN adduser --uid 23456 --disabled-password --gecos "" --home /data run-user && chown run-user:run-user -R /run/lock/apache2 /run/apache2 /var/log/apache2 /var/cache/apache2/ /data
ENV APACHE_RUN_USER run-user
ENV APACHE_RUN_GROUP run-user
RUN a2enmod remoteip
RUN echo "\nRemoteIPHeader X-Forwarded-For\nSetEnvIf X-Forwarded-Proto https HTTPS=on" >> /etc/apache2/apache2.conf
VOLUME /data
