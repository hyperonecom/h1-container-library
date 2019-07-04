FROM chialab/php:5.6-apache
LABEL maintainer="HyperOne"
LABEL rbx.shell_image="quay.io/hyperone/php-apache-shell:5.6"
ENV IMAGICK_VERSION="3.4.4"
RUN sed -i 's@DocumentRoot .*@DocumentRoot /data/public@g' /etc/apache2/sites-available/000-default.conf && \
sed -i 's@Directory /var/www/@Directory /data/public@g' /etc/apache2/conf-available/docker-php.conf /etc/apache2/apache2.conf
RUN echo "https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_$(uname -m | sed 's/_/-/g').tar.gz"
RUN curl "https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_$(uname -m | sed 's/_/-/g').tar.gz" -s -o /tmp/ioncube.tar.gz \
&& extension_dir=$(php -i | sed -n -E '/extension_dir/s/^extension_dir.+?=> (.+?)/\1/gp') \
&& tar -xzvf /tmp/ioncube.tar.gz --strip-components=1 -C "$extension_dir" "ioncube/ioncube_loader_lin_5.6.so" \
&& chown root:staff "$extension_dir/ioncube_loader_lin_5.6.so" \
&& echo "zend_extension = $extension_dir/ioncube_loader_lin_5.6.so" > /usr/local/etc/php/php.ini \
&& rm /tmp/ioncube.tar.gz
RUN apt-get update \
# Following command add 200 MB dependencies
&& apt-get install -y --no-install-recommends zlib1g-dev libcurl3-dev libpng-dev libmagickwand-dev \
&& rm -rf /var/lib/apt/lists/* \
&& pecl install imagick-"$IMAGICK_VERSION" \
&& docker-php-ext-enable imagick

RUN adduser --uid 23456 --disabled-password --gecos "" --home /data run-user && chown run-user:run-user -R /run/lock/apache2 /run/apache2 /var/log/apache2 /var/cache/apache2/ /data
ENV APACHE_RUN_USER run-user
ENV APACHE_RUN_GROUP run-user
RUN a2enmod remoteip
RUN echo "\nRemoteIPHeader X-Forwarded-For\nSetEnvIf X-Forwarded-Proto https HTTPS=on" >> /etc/apache2/apache2.conf
VOLUME /data
