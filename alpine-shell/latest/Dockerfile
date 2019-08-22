FROM alpine
LABEL maintainer="HyperOne"
WORKDIR /data
RUN apk add --repository "http://dl-cdn.alpinelinux.org/alpine/edge/testing" h1-cli
RUN apk add --no-cache rsync wget nano mc vim mariadb-client openssh-sftp-server zip unzip subversion postgresql-client
RUN ln -s /usr/lib/ssh/sftp-server /usr/bin/sftp-server
RUN adduser --uid 23456 --disabled-password --gecos "" --home /data run-user && chown run-user:run-user -R /data
USER run-user
## TODO: Fix locale issues - https://gitlab.com/rilian-la-te/musl-locales/issues/6
