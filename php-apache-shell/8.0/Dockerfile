FROM h1cr.io/website/php-apache:8.0
LABEL maintainer="HyperOne"
ENV WP_CLI_VERSION="2.1.0"
RUN fetchDeps="gnupg lsb-release" \
&& VERSION_CODENAME=$(sed -E -n 's/VERSION=.*\((.+?)\).*$/\1/gp' /etc/os-release) \
&& apt-get update \
&& apt-get install -y --no-install-recommends $fetchDeps git less rsync wget nano mc vim mariadb-client zip unzip openssh-sftp-server subversion locales \
&& curl -fsSL "https://www.postgresql.org/media/keys/ACCC4CF8.asc" | apt-key add - \
&& curl -fsSL "http://packages.hyperone.cloud/gpg.public.txt" | apt-key add - \
&& echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -c -s)-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
&& echo "deb [arch=amd64] http://packages.hyperone.cloud/linux/debian/ $VERSION_CODENAME stable" > /etc/apt/sources.list.d/hyperone.list \
&& apt-get update \
&& apt-get install -y --no-install-recommends h1-cli postgresql-client-10 \
&& apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $fetchDeps \
&& rm -rf /var/lib/apt/lists/*
RUN curl -s -L "https://github.com/wp-cli/wp-cli/releases/download/v${WP_CLI_VERSION}/wp-cli-${WP_CLI_VERSION}.phar" -o /usr/local/bin/wp \
&& chmod +x /usr/local/bin/wp
RUN ln -s /usr/lib/openssh/sftp-server /usr/bin/sftp-server
WORKDIR /data
USER run-user
CMD ["/bin/bash"]
