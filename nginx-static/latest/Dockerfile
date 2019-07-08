FROM nginx:alpine
LABEL maintainer="HyperOne"
LABEL rbx.shell_image="h1cr.io/website/debian-shell:latest"
WORKDIR /data
ADD ./nginx.conf /etc/nginx/nginx.conf
RUN adduser --uid 23456 --disabled-password --gecos "" --home /data run-user && chown run-user:run-user -R /data
