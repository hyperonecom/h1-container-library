FROM quay.io/hyperone/php-apache:7.2
LABEL maintainer="HyperOne"
ENV WP_CLI_VERSION="2.1.0"
RUN fetchDeps="gnupg lsb-release" \
&& apt-get update \
&& apt-get install -y --no-install-recommends $fetchDeps rsync wget nano mc vim mariadb-client openssh-sftp-server subversion locales \
&& wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
&& echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -c -s)-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
&& apt-get update \
&& apt-get install -y --no-install-recommends postgresql-client-10 \
&& apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $fetchDeps \
&& rm -rf /var/lib/apt/lists/*
RUN curl -s -L "https://github.com/wp-cli/wp-cli/releases/download/v${WP_CLI_VERSION}/wp-cli-${WP_CLI_VERSION}.phar" -o /usr/local/bin/wp \
&& chmod +x /usr/local/bin/wp
RUN curl -s -L "https://github.com/hyperonecom/h1-cli/releases/latest/download/h1-linux" -o /usr/local/bin/h1 \
&& chmod +x /usr/local/bin/h1
RUN ln -s /usr/lib/openssh/sftp-server /usr/bin/sftp-server
WORKDIR /data
USER run-user
CMD ["/bin/bash"]
