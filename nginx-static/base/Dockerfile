FROM nginx:alpine
ADD ./nginx.conf /etc/nginx/nginx.conf
RUN adduser --uid 23456 --disabled-password --gecos "" --home /data run-user && chown run-user:run-user -R /data
