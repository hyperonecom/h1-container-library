FROM quay.io/hyperone/php-apache:%%PHP_VERSION%%
LABEL maintainer="HyperOne"
ENV WP_CLI_VERSION="2.1.0"
ENV H1_CLI_VERSION="1.4.0"
RUN apt-get update \
&& apt-get install -y --no-install-recommends wget nano mariadb-client \
&& rm -rf /var/lib/apt/lists/*
RUN curl -s -L "https://github.com/wp-cli/wp-cli/releases/download/v${WP_CLI_VERSION}/wp-cli-${WP_CLI_VERSION}.phar" -o /usr/local/bin/wp \
&& chmod +x /usr/local/bin/wp
RUN curl -s -L "https://github.com/hyperonecom/h1-cli/releases/latest/download/h1-linux" -o /usr/local/bin/h1 \
&& chmod +x /usr/local/bin/h1
WORKDIR /data
CMD ["/bin/bash"]
