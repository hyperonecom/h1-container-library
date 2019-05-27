FROM chialab/php:5.6-apache
LABEL maintainer="HyperOne"
LABEL rbx.shell_image="quay.io/hyperone/php-apache-shell:5.6"
RUN rm -r /var/www/html && ln -s /data/public /var/www/html
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl -s "https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_$(uname -m | sed 's/_/-/g').tar.gz" -o /tmp/ioncube.tar.gz \
&& extension_dir=$(php -i | sed -n -E '/extension_dir/s/^extension_dir.+?=> (.+?)/\1/gp') \
&& tar -xzvf /tmp/ioncube.tar.gz --strip-components=1 -C "$extension_dir" "ioncube/ioncube_loader_lin_5.6.so" \
&& chown root:staff "$extension_dir/ioncube_loader_lin_5.6.so" \
&& printf "zend_extension = %s/ioncube_loader_lin_5.6.so" "$extension_dir" > /usr/local/etc/php/php.ini \
&& rm /tmp/ioncube.tar.gz
RUN adduser -uid 23456 --disabled-password --gecos "" --home /data run-user && chown run-user:run-user -R /run/lock/apache2 /run/apache2 /var/log/apache2 /var/cache/apache2/ /data
ENV APACHE_RUN_USER run-user
ENV APACHE_RUN_GROUP run-user
RUN a2enmod remoteip && printf "\nRemoteIPHeader X-Forwarded-For\nSetEnvIf X-Forwarded-Proto https HTTPS=on" >> /etc/apache2/apache2.conf
VOLUME /data
