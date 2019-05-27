FROM quay.io/hyperone/php-apache:7.2
LABEL maintainer="HyperOne"
ENV WP_CLI_VERSION="2.1.0"
ENV H1_CLI_VERSION="1.5.1"
ENV WGET_VERSION="1.18-5+deb9u3"
ENV NANO_VERSION="2.7.4-1"
ENV VIM_VERSION="2:8.0.0197-4+deb9u1"
ENV MARIADB_CLIENT_VERSION="10.1.38-0+deb9u1"
ENV OPENSSH_SFTP_VERSION="1:7.4p1-10+deb9u6"
ENV MC_VERSION="3:4.8.18-1"
RUN apt-get update \
&& apt-get install -y --no-install-recommends \
wget="$WGET_VERSION" \
nano="$NANO_VERSION" \
mc="$MC_VERSION" \
vim="$VIM_VERSION" \
mariadb-client="$MARIADB_CLIENT_VERSION" \
openssh-sftp-server="$OPENSSH_SFTP_VERSION" \
&& rm -rf /var/lib/apt/lists/*
RUN curl -s -L "https://github.com/wp-cli/wp-cli/releases/download/v${WP_CLI_VERSION}/wp-cli-${WP_CLI_VERSION}.phar" -o /usr/local/bin/wp \
&& chmod +x /usr/local/bin/wp
RUN curl -s -L "https://github.com/hyperonecom/h1-cli/releases/latest/download/h1-linux" -o /usr/local/bin/h1 \
&& chmod +x /usr/local/bin/h1
WORKDIR /data
USER run-user
CMD ["/bin/bash"]
