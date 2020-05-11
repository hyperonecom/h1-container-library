FROM node:{{NODE_VERSION}}
LABEL maintainer="HyperOne"
LABEL rbx.shell_cmd="/bin/bash"
RUN apt-get update \
&& apt-get install -y --no-install-recommends ca-certificates git less rsync curl zip unzip wget nano mc vim mariadb-client openssh-sftp-server postgresql-client subversion locales \
&& VERSION_CODENAME=$(sed -E -n 's/VERSION=.*\((.+?)\).*$/\1/gp' /etc/os-release) \
&& fetchDeps="gnupg" \
&& apt-get update \
&& apt-get install -y --no-install-recommends ${fetchDeps} \
&& curl -fsSL "http://packages.hyperone.cloud/gpg.public.txt" | apt-key add - \
&& echo "deb [arch=amd64] http://packages.hyperone.cloud/linux/debian/ $VERSION_CODENAME stable" > /etc/apt/sources.list.d/hyperone.list \
&& apt-get update \
&& apt-get install -y --no-install-recommends h1-cli \
&& apt-get remove -y ${fetchDeps} \
&& rm -rf /var/lib/apt/lists/*
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
ENV NODE_VERSION {{NODE_VERSION}}
ENV PORT 8080
CMD ["node", "app"]