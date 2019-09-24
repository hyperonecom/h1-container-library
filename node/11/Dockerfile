FROM node:11
LABEL maintainer="HyperOne"
LABEL rbx.shell_cmd="/bin/bash"
RUN apt-get update \
&& apt-get install -y --no-install-recommends ca-certificates rsync curl zip unzip wget nano mc vim mariadb-client openssh-sftp-server subversion locales \
&& rm -rf /var/lib/apt/lists/*
RUN curl -s -L "https://github.com/hyperonecom/h1-cli/releases/latest/download/h1-linux.tar.gz" -o /usr/local/bin/h1.tar.gz \
&& tar xvzf /usr/local/bin/h1.tar.gz \
&& mv h1 /usr/local/bin/h1 \
&& rm /usr/local/bin/h1.tar.gz
RUN ln -s /usr/lib/openssh/sftp-server /usr/bin/sftp-server
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
&& dpkg-reconfigure --frontend=noninteractive locales \
&& update-locale LANG=en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN adduser --uid 23456 --disabled-password --gecos "" --home /data run-user && chown run-user:run-user -R /data
USER run-user
WORKDIR /data
ENV PORT 8080
CMD ["node", "public/app.js"]