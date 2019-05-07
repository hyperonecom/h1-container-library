FROM chialab/php:%%PHP_VERSION%%-apache
LABEL maintainer="HyperOne"
LABEL rbx.shell_image="quay.io/hyperone/php-apache-shell:%%PHP_VERSION%%"
RUN rm -r /var/www/html && ln -s /data/public /var/www/html
RUN echo "https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_$(uname -m | sed 's/_/-/g').tar.gz"
RUN curl "https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_$(uname -m | sed 's/_/-/g').tar.gz" -o /tmp/ioncube.tar.gz \
&& extension_dir=$(php -i | sed -n -E '/extension_dir/s/^extension_dir.+?=> (.+?)/\1/gp') \
&& tar -xzvf /tmp/ioncube.tar.gz --strip-components=1 -C "$extension_dir" "ioncube/ioncube_loader_lin_%%PHP_VERSION%%.so" \
&& chown root:staff "$extension_dir/ioncube_loader_lin_%%PHP_VERSION%%.so" \
&& echo "zend_extension = $extension_dir/ioncube_loader_lin_%%PHP_VERSION%%.so" > /usr/local/etc/php/php.ini \
&& rm /tmp/ioncube.tar.gz
RUN adduser -uid 23456 --disabled-password --gecos "" --home /var/www run-user && chown run-user:run-user -R /run/lock/apache2 /run/apache2 /var/log/apache2 /var/cache/apache2/
ENV APACHE_RUN_USER run-user
ENV APACHE_RUN_GROUP run-user
VOLUME /data
