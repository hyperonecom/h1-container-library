FROM chialab/php:7.2-apache
LABEL maintainer="HyperOne"
LABEL rbx.shell_image="quay.io/hyperone/php-apache-shell:7.2"
RUN rm -r /var/www/html && ln -s /data/public /var/www/html
RUN curl https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -o /tmp/ioncube.tar.gz \
&& extension_dir=$(php -i | sed -n -E '/extension_dir/s/^extension_dir.+?=> (.+?)/\1/gp') \
&& tar -xzvf /tmp/ioncube.tar.gz --strip-components=1 -C "$extension_dir" "ioncube/ioncube_loader_lin_7.2.so" \
&& chown root:staff "$extension_dir/ioncube_loader_lin_7.2.so" \
&& echo "zend_extension = $extension_dir/ioncube_loader_lin_7.2.so" > /usr/local/etc/php/php.ini \
&& rm /tmp/ioncube.tar.gz
VOLUME /data
