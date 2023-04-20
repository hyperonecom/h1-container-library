FROM chialab/php:7.2-apache
LABEL maintainer="HyperOne"
LABEL rbx.shell_image="h1cr.io/website/php-apache-shell:7.2"
COPY ./site.conf /etc/apache2/sites-available/000-default.conf
COPY ./ports.conf /etc/apache2/ports.conf
RUN sed -i 's@Directory /var/www/@Directory /data/public@g' /etc/apache2/conf-available/docker-php.conf /etc/apache2/apache2.conf
RUN curl "https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_$(uname -m | sed 's/_/-/g').tar.gz" -s -o /tmp/ioncube.tar.gz \
&& extension_dir=$(php -i | sed -n -E '/extension_dir/s/^extension_dir.+?=> (.+?)/\1/gp') \
&& tar -xzvf /tmp/ioncube.tar.gz --strip-components=1 -C "$extension_dir" "ioncube/ioncube_loader_lin_7.2.so" \
&& chown root:staff "$extension_dir/ioncube_loader_lin_7.2.so" \
&& rm /tmp/ioncube.tar.gz
RUN apt-get update && apt-get install -y \
    locales \
    && rm -rf /var/lib/apt/lists/*
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
