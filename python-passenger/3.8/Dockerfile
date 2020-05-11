FROM python:3.8-slim
LABEL maintainer="HyperOne"
LABEL rbx.shell_cmd="/bin/bash"
WORKDIR /data
# Install standard tools
RUN apt-get update \
&& apt-get install -y --no-install-recommends ca-certificates git less rsync curl zip unzip wget nano mc vim mariadb-client openssh-sftp-server postgresql-client subversion locales \
&& VERSION_CODENAME=$(sed -E -n 's/VERSION=.*\((.+?)\).*$/\1/gp' /etc/os-release) \
&& fetchDeps="gnupg" \
&& apt-get update \
&& apt-get install -y --no-install-recommends ${fetchDeps} \
&& curl -fsSL "http://packages.hyperone.cloud/gpg.public.txt" | apt-key add - \
&& echo "deb [arch=amd64] http://packages.hyperone.cloud/linux/debian/ $VERSION_CODENAME stable" > /etc/apt/sources.list.d/hyperone.list \
&& ln -s /usr/lib/openssh/sftp-server /usr/bin/sftp-server \
&& apt-get update \
&& apt-get install -y --no-install-recommends h1-cli \
&& apt-get remove -y ${fetchDeps} \
&& sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
&& dpkg-reconfigure --frontend=noninteractive locales \
&& update-locale LANG=en_US.UTF-8 \
&& rm -rf /var/lib/apt/lists/*
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
# Install virtualenv
RUN pip install virtualenv
# Install Nginx
RUN apt-get update && apt-get install -y dirmngr gnupg nginx && \
rm /var/log/nginx/* && \
ln -s /dev/stdout /var/log/nginx/access.log && \
ln -s /dev/stderr /var/log/nginx/error.log && \
mkdir /tmp/nginx && \
rm -r /var/lib/nginx && \
ln -s /tmp/nginx /var/lib/nginx
# Install Passenger
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7 && \
apt-get install -y apt-transport-https ca-certificates && \
sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger buster main > /etc/apt/sources.list.d/passenger.list' && \
apt-get update && \
apt-get install -y libnginx-mod-http-passenger && \
rm -rf /var/lib/apt/lists/*
ADD ./start.sh /
ADD ./nginx.conf /etc/nginx/nginx.conf
ADD ./default_python.sh /bin/default_python
ENV PYTHONPATH="/data/app/:$PATH"
RUN adduser --uid 23456 --disabled-password --gecos "" --home /data run-user && mkdir /var/cache/nginx && chown run-user:run-user -R /data /var/cache/nginx/ /var/run/ /var/lib/nginx /tmp/nginx;
USER run-user
CMD ["/start.sh"]