FROM alpine
LABEL maintainer="HyperOne"
WORKDIR /data
# RUN apk add --repository "http://dl-cdn.alpinelinux.org/alpine/edge/testing" h1-cli
RUN wget -c https://github.com/hyperonecom/h1-cli/releases/download/v2.3.2/h1-linux.tar.gz -O - | tar -xz -C /bin
RUN apk add --no-cache curl git less rsync wget nano mc vim mariadb-client openssh-sftp-server zip unzip subversion postgresql-client
RUN ln -s /usr/lib/ssh/sftp-server /usr/bin/sftp-server
RUN adduser --uid 23456 --disabled-password --gecos "" --home /data run-user && chown run-user:run-user -R /data
USER run-user
## TODO: Fix locale issues - https://gitlab.com/rilian-la-te/musl-locales/issues/6
