FROM alpine
LABEL maintainer="HyperOne"
WORKDIR /data
RUN apk add --repository "http://dl-cdn.alpinelinux.org/alpine/edge/testing" h1-cli
RUN apk add --no-cache rsync wget nano mc vim mariadb-client openssh-sftp-server subversion postgresql-client
RUN ln -s /usr/lib/openssh/sftp-server /usr/bin/sftp-server
## TODO: Fix locale issues - https://gitlab.com/rilian-la-te/musl-locales/issues/6
